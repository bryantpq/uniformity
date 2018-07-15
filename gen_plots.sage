import re
import json

def cleanData():
    s = open("lmfdb_data.txt").read()
    numUnverified = 0
    cleaned = []
    for l in s.splitlines():
        label,coeffs,points,verified = re.findall('^([^,]+),(\\[\\[.*?\\]\\]),((?:\\[\\[.*?\\]\\])|\\[\\]),(\\d)$',l)[0]
        coeffs = json.loads(coeffs)
        points = json.loads(points)
        verified  = json.loads(verified)
        #print verified == 1
        affinePoints = []
        for i in points:
            if i[2] == 1:
                affinePoints.append(i)
        #cleaned.append((label, coeffs, affinePoints, verified)) # uncomment
        if verified != 1:
            #print 'here'
            numUnverified += 1
            cleaned.append((label,coeffs, affinePoints, verified)) # comment
    return (cleaned,numUnverified)


def get_stats(l):
    return mode(l), median(l), mean(l), variance(l)


l = load("g2_data.sobj")
h1 = histogram([len(d[1]) for d in l],color="red", xmax = 25, ymax=8000, bins=51, rwidth=1, axes_labels = ['No. of \nrational points', 'No. of curves'], axes_labels_size=1)

lmfdbPoints = cleanData()
j = lmfdbPoints[0]
h2 = histogram([len(d[2]) for d in j],color="blue", xmax = 25, ymax=8000, bins=30, rwidth=1, axes_labels = ['No. of \nrational points', 'No. of curves'], axes_labels_size=1)

h1.save('finalHistOurPointsUnverified.eps')
h2.save('finalHistLMFDBPointsUnverified.eps')

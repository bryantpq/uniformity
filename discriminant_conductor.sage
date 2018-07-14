def gen2disc(C):
    '''
    Given a particular hyperelliptic curve of genus = 2, return the absolute discriminant of said curve
    '''
    g = C.genus()
    f,h = C.hyperelliptic_polynomials()
    specPoly = (f + (h^2)/4) # linear combination of f and h used in calculating the discriminant

    if (specPoly.degree() % 2 == 0):
        return abs((2^(4*g)) * discriminant(specPoly))
    else:
        return abs((2^(4*g)) * ((f.leading_coefficient())^2) * discriminant(specPoly))


def gen2cond(C):
    '''
    Given a particular hyperelliptic curve of genus = 2, return the conductor of said curve
    '''
    f, h = C.hyperelliptic_polynomials()
    gen2red = genus2reduction(h, f)
    return gen2red.conductor

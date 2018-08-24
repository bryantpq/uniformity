def call_stoll(coeffs, infinity=True,H=1000):
    '''
    Run the ratpoints program with coefficients for a polynomial.
    Returns a parsed list of points.

    EXAMPLES:

    >>> call_stoll([1,2,3,4,5], H=10)
    [[0, 1, 1], [0, -1, 1], [-1, 3, 2], [-1, -3, 2], [6, 125, 5], [6, -125, 5]]
    '''
    # recompile the ratpoints file if it doesnt work
    args = ['../Ratpoints/ratpoints-2.1.3/ratpoints', ""+" ".join(map(str,coeffs))+"", str(H)]
    if not infinity: args.append("-i")
    output = sp.check_output(args) # `output` is a string of the form "(1 : 17 : 3)(0 : 1 : 0)"
    return [
        map(QQ,list(v))
        for v in re.findall('(?:\((-?\d+) : (-?\d+) : (-?\d+)\))+?',output)
    ]

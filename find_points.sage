def find_points(C,H=1000):
    """
    Given a hyperelliptic curve C and bound H,
    this returns the affine rational points found by
    running Stoll's program.

    EXAMPLES:

    >>> R.<x> = PolynomialRing(QQ)
    >>> C = HyperellipticCurve(R([1,2,3,4,5]), R([0])) # genus 1!
    >>> find_points(C, H=10)
    [(0 : 1 : 1), (0 : -1 : 1), (-1/2 : 3/4 : 1), (-1/2 : -3/4 : 1), (6/5 : 5 : 1), (6/5 : -5 : 1)]

    """
    g = C.genus()
    f,h = C.hyperelliptic_polynomials()
    return [
        # We transform the curve to a "normal" form by
        # (2*(y + z^()*h(x)/2))^2 = 4*f(x) + h(x)^2
        # Also, we need to transform from weighted projective space
        # to regular projective space. The usual weights are deg x = 1, deg y = g+1, deg z = 1
        # so we set X=x/z and Y=y/z^(g+1)
        C([x/z, (1/2*y - h(x=x/z)*z^(g+1) / 2)/z^(g+1), 1])
        for [x,y,z] in call_stoll((4*f + h^2).coefficients(sparse=False),infinity=False,H=H)
    ]

declare type CryptoMyCrvEll[CryptoMyPtEll]: FinCycGrp;
declare type CryptoMyPtEll: FinCycGrpElt;
declare attributes CryptoMyCrvEll: Curve, Generator, Order, Cofactor;

intrinsic Print(crv::CryptoMyCrvEll)
{Print crv}
    printf
        "Crypto-elliptic curve with %o and generator %o generating a subgroup of order %o with cofactor %o",
        crv`Curve,
        crv`Generator,
        crv`Order,
        crv`Cofactor;
end intrinsic;

intrinsic CryptoMyEllipticCurve(
    a::FldElt,
    b::FldElt,
    G::FldElt,
    order::RngIntElt,
    cofactor::RngIntElt
) -> CryptoMyCrvEll
{Create an elliptic curve for cryptographic purposes of the form
y^2 = x^3 + a x + b
over the same finite field as a, b and G.

With cyclic subgroup generated by G
(where G is the x-coordinate of the generator element on the curve).
Further, the order and cofactor of the cyclic subgroup must be given.
}
    c := New(CryptoMyCrvEll);
    c`Curve := MyEllipticCurve(a, b);
    has_point, c`Generator := Point(c`Curve, G);
    c`Order := order;
    c`Cofactor := cofactor;
    return c;
end intrinsic;

intrinsic GeneratingElement(crv::CryptoMyCrvEll) -> CryptoMyPtEll
{Get the generating element of the curve.}
    elt := New(CryptoMyPtEll);
    elt`Value := crv`Generator;
    elt`Parent := crv;
    return elt;
end intrinsic;

intrinsic Order(crv::CryptoMyCrvEll) -> RngIntElt
{Get the order of the finite cyclic subgroup generated by the generator on the
 curve.
}
    return crv`Order;
end intrinsic;

intrinsic '^'(e::CryptoMyPtEll, n::RngIntElt) -> CryptoMyPtEll
{Return e^n.}
    elt := New(CryptoMyPtEll);
    elt`Value := e`Value * n;
    elt`Parent := e`Parent;
    return elt;
end intrinsic;

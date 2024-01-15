module sevenseg(
    input b3,
    input b2,
    input b1,
    input b0,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output dp,
    output an3,
    output an2,
    output an1,
    output an0
    );
    
    and an3_1(an3, 1, 1);
    and an2_1(an2, 1, 1);
    and an1_1(an1, 1, 1);
    and an0_0(an0, 0, 0);
    and dp_1(dp, 1, 1);
    
    wire b3_not, b2_not, b1_not, b0_not;
    
    not n0(b0_not, b0);
    not n1(b1_not, b1);
    not n3(b2_not, b2);
    not n2(b3_not, b3);

// a = b3 b2 + b3 b1 + b3' b2' b1' b0 + b2 b1' b0'
    wire a_and0, a_and1, a_and2, a_and3;
    
    and a0_(a_and0, b3, b2);
    and a1_(a_and1, b3, b1);
    and a2_(a_and2, b3_not, b2_not, b1_not, b0);
    and a3_(a_and3, b2, b1_not, b0_not);
    
    or a_out(a, a_and0, a_and1, a_and2, a_and3);
    
// b = b3 b2 + b3 b1 + b2 b1' b0 + b2 b1 b0'
    wire b_and0, b_and1, b_and2, b_and3;
    
    and b0_(b_and0, b3, b2);
    and b1_(b_and1, b3, b1);
    and b2_(b_and2, b2, b1_not, b0);
    and b3_(b_and3, b2, b1, b0_not);
    
    or b_out(b, b_and0, b_and1, b_and2, b_and3);
    
// c = b3 b2 + b3 b1 + b2' b1 b0'
    wire c_and0, c_and1, c_and2;
    
    and c0_(c_and0, b3, b2);
    and c1_(c_and1, b3, b1);
    and c2_(c_and2, b2_not, b1, b0_not);
    
    or c_out(c, c_and0, c_and1, c_and2);
    
// d = b3 b2 + b3 b1 + b2 b1' b0' + b2' b1' b0 + b2 b1 b0
    wire d_and0, d_and1, d_and2, d_and3, d_and4;
    
    and d0_(d_and0, b3, b2);
    and d1_(d_and1, b3, b1);
    and d2_(d_and2, b2, b1_not, b0_not);
    and d3_(d_and3, b2_not, b1_not, b0);
    and d4_(d_and4, b2, b1, b0);
    
    or d_out(d, d_and0, d_and1, d_and2, d_and3, d_and4);
    
// e = b3' b0 + b2 b1' + b3 b0 + b3 b2
    wire e_and0, e_and1, e_and2, e_and3;
    
    and e0_(e_and0, b3, b1);
    and e1_(e_and1, b3, b0);
    and e2_(e_and2, b3_not, b0);
    and e3_(e_and3, b2, b1_not);
    
    or e_out(e, e_and0, e_and1, e_and2, e_and3);
    
// f = b3 b2 + b1 b0 + b3' b2' b0 + b2' b1
    wire f_and0, f_and1, f_and2, f_and3;
    
    and f0_(f_and0, b3, b2);
    and f1_(f_and1, b1, b0);
    and f2_(f_and2, b3_not, b2_not, b0);
    and f3_(f_and3, b2_not, b1);
    
    or f_out(f, f_and0, f_and1, f_and2, f_and3);

// g = b3 b2 + b3 b1 + b2 b1 b0 + b3' b2' b1'
    wire g_and0, g_and1, g_and2, g_and3;
    
    and g0_(g_and0, b3, b2);
    and g1_(g_and1, b3, b1);
    and g2_(g_and2, b2, b1, b0);
    and g3_(g_and3, b3_not, b2_not, b1_not);
    
    or g_out(g, g_and0, g_and1, g_and2, g_and3);

endmodule
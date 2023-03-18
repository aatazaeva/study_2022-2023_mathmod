model lab6_1

parameter Real a = 0.02;
parameter Real b = 0.01;

Real S(start = 11000);
Real I(start = 111);
Real R(start = 11);

equation
  der(S) = 0;
  der(I) = b*I;
  der(R) =-b*I;
  
end lab6_1;

package PDEDomains
  import C = Modelica.Constants;
  record DomainLineSegment1D
    parameter Real l = 1;
    parameter Real a = 0;
    function shapeFunc
      input Real v;
      output Real x = l*v + a;
    end shapeFunc;
    Coordinate x (name = "cartesian");
    Region1D interior(shape = shapeFunc, interval = {0,1});
    Region0D left(shape = shapeFunc, interval = 0);
    Region0D right(shape = shapeFunc, interval = 1);
    Region0D boundary = left + right;
  end DomainLineSegment1D;

  class DomainRectangle2D
    parameter Real Lx = 1;
    parameter Real Ly = 1;
    parameter Real ax = 0;
    parameter Real ay = 0;
    function shapeFunc
      input Real v1, v2;
      output Real x = ax + Lx * v1, y = ay + Ly * v2;
    end shapeFunc;

    Coordinate x (name = "cartesian");
    Coordinate y (name = "cartesian");

    Coordinate r (name = "polar");
    Coordinate theta (name = "polar");

    equation
      r = sqrt(x^2 + y^2);
      theta = arctg(y/x);

    Region2D interior(shape = shapeFunc, interval = {{0,1},{0,1}});
    Region1D right(shape = shapeFunc, interval = {1,{0,1}});
    Region1D bottom(shape = shapeFunc, interval = {{0,1},0});
    Region1D left(shape = shapeFunc, interval = {0,{0,1}});
    Region1D top(shape = shapeFunc, interval = {{0,1},1});
    Region1D boundary = right + bottom + left + top;
  end DomainRectangle2D;

  class DomainCircular2D
    parameter Real radius = 1;
    parameter Real cx = 0;
    parameter Real cy = 0;
    function shapeFunc
      input Real r,v;
      output Real x,y;
    algorithm
      x:=cx + radius * r * cos(2 * C.pi * v);
      y:=cy + radius * r * sin(2 * C.pi * v);
    end shapeFunc;

    Coordinate x (name="cartesian");
    Coordinate y (name="cartesian";

    Coordinate r (name="polar");
    Coordinate theta (name="polar");

    equation
      r = sqrt(x^2 + y^2);
      theta = arctg(y/x);
    end polar;

    Region2D interior(shape = shapeFunc, interval = {{O,1},{O,1}});
    Region1D boundary(shape = shapeFunc, interval = {1,{0,1}});
  end DomainCircular2D;

  record DomainBlock3D
    parameter Real Lx = 1, Ly = 1, Lz = 1;
    parameter Real ax = 0, ay = 0, az = 0;
    function shapeFunc
      input Real vx, vy, vz;
      output Real x = ax + Lx * vx, y = ay + Ly * vy, z = az + Lz * vz;
    end shapeFunc;
    Coordinate x (name="cartesian");
    Coordinate y (name="cartesian");
    Coordinate z (name="cartesian");
    Region3D interior(shape = shapeFunc, interval = {{0,1},{0,1},{0,1}});
    Region2D right(shape = shapeFunc, interval = {1,{0,1},{0,1}});
    Region2D bottom(shape = shapeFunc, interval = {{0,1},{0,1},1});
    Region2D left(shape = shapeFunc, interval = {0,{0,1},{0,1}});
    Region2D top(shape = shapeFunc, interval = {{0,1},{0,1},1});
    Region2D front(shape = shapeFunc, interval = {{0,1},0,{0,1}});
    Region2D rear(shape = shapeFunc, interval = {{0,1},1,{0,1}});
    Region2D boundary = right + bottom + left + top + front + rare;
  end DomainBlock3D;
  //and others ...
end PDEDomains;

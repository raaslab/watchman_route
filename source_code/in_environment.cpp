/*
=========A VisiLibity Example Program=========

This MEX-file source code is for testing whether a point (test_x,
test_y) is in an environment (w/in epsilon) represented in Matlab as a
cell array.

To compile, first make visilibity.o if it has not already been made.
Then set up your MEX compiler at the Matlab prompt using the command
>>mex -setup
, and finally to generate the MEX file at the Matlab prompt run
>> mex -v in_environment.cpp visilibity.o
.  To call the MEX-file from the Matlab prompt, use
>>in_environment([test_x test_y], environment, epsilon)
, where
test_x and test_y are scalars (x and y coordinates),
environment is a cell array of the environment vertices
(x and y coordinates), and
epsilon is a double (the robustness constant).
*/


//Gives Matlab interfacing.  Linkage block specifies linkage
//convention used to link header file; makes the C header suitable for
//C++ use.  "mex.h" also includes "matrix.h" to provide MX functions
//to support Matlab data types, along with the standard header files
//<stdio.h>, <stdlib.h>, and <stddef.h>.
extern "C" {
#include <math.h>
#include "mex.h"
}


#include "visilibity.hpp"  //VisiLibity header file
//#include <cmath>         //Puts math functions in std namespace
#include <cstdlib>       //rand, srand, exit
#include <ctime>         //Unix time
#include <fstream>       //File I/O
#include <iostream>      //std I/O
#include <cstring>       //C-string manipulation
#include <string>        //string class
#include <sstream>       //string streams
#include <vector>        //std vectors
//#define NDEBUG           //Turns off assert.
#include <cassert>


//=========================Main=========================//
//nlhs contains the number of LHS (output) arguments and corresponds
//to the number returned from the Matlab nargout function.  plhs[] is
//an array of pointers to the output arguments (mxArrays).  nrhs
//contains the number or RHS (input arguments).  prhs[] is an array of
//pointers to the input arguments (mxArrays), i.e. prhs[0] points to
//first input argument, prhs[nrhs-1] to last input argument, etc..
//When the function is called, prhs contains pointers to the input
//arguments, while plhs contains null pointers.  Must create output
//arrays and assign pointers to the plhs pointer array.
void mexFunction( int nlhs, mxArray *plhs[],
		  int nrhs, const mxArray *prhs[] )
{

  //Construct Point to be tested
  double *in0 = mxGetPr( prhs[0] );
  double test_x = in0[0];
  double test_y = in0[1];
  VisiLibity::Point test_point(test_x, test_y);



  //Construct environment
  //Passing structures and cell arrays into MEX-files is just like
  //passing any other data types, except the data itself is of type
  //mxArray. In practice, this means that mxGetField (for structures)
  //and mxGetCell (for cell arrays) return pointers of type
  //mxArray. You can then treat the pointers like any other pointers
  //of type mxArray, but if you want to pass the data contained in the
  //mxArray to a C routine, you must use an API function such as
  //mxGetData to access it.
  //
  //Find the dimensions of input
  //int m = mxGetM(prhs[1]);
  //int n = mxGetN(prhs[1]);


  //Auxiliary vars
  //Recall const My_type *my_ptr => my_ptr points to a constant of
  //type My_type, i.e., my_ptr is not a constant pointer to a variable
  //of type My_type.
  const mxArray *polygon_ptr;
  int num_of_coords;
  //coord_ptr is indexable, e.g., my_coord[0] returns the x
  //coordinate of the first vertex.
  const double *coord_ptr;
  std::vector<VisiLibity::Point> vertices;
  VisiLibity::Polygon polygon_temp;


  //Outer Boundary
  polygon_ptr = mxGetCell(prhs[1], 0);
  num_of_coords = mxGetM(polygon_ptr);
  //mexPrintf("The outer boundary has %i vertices.\n", num_of_coords); 
  coord_ptr = mxGetPr( polygon_ptr );
  for(int j=0; j<num_of_coords; j++){
    vertices.push_back(  VisiLibity::Point( coord_ptr[j],
					    coord_ptr[num_of_coords + j] )  );
  }
  //VisiLibity::Environment my_environment( VisiLibity::Polygon(vertices) );
  polygon_temp.set_vertices(vertices);
  VisiLibity::Environment *my_environment;
  my_environment = new VisiLibity::Environment(polygon_temp);
  vertices.clear();


  //Holes  
  //The number of polygons is the number of cells (one polygon
  //per cell).
  int num_of_polygons = mxGetNumberOfElements( prhs[1] );
  for(int i=1; i<num_of_polygons; i++){

    polygon_ptr = mxGetCell(prhs[1], i);
    num_of_coords = mxGetM(polygon_ptr);
    //mexPrintf("The hole #%i has %i vertices.\n", i, num_of_coords); 
    coord_ptr = mxGetPr( polygon_ptr );
    for(int j=0; j<num_of_coords; j++){
      vertices.push_back(  VisiLibity::Point( coord_ptr[j],
				  coord_ptr[num_of_coords + j] )  );
    } 
    
    polygon_temp.set_vertices( vertices );
    my_environment->add_hole( polygon_temp );
    //:COMPILER:
    //Why doesn't this work if my_environment were not a pointer?
    //my_environment.add_hole( polygon_temp );
    vertices.clear();
  }


  //Get robustness constant
  double epsilon = mxGetScalar(prhs[2]);
 

  //Create an mxArray for the output
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL );
  //Create a pointer to output
  double *out = mxGetPr(plhs[0]);
  //Populate the output
  out[0] = static_cast<double>( test_point.in( *my_environment , epsilon ) );
  

  delete my_environment;

  return;
}

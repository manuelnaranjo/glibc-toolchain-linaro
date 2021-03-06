/* Definitions for double vector tests with vector length 2.
   Copyright (C) 2014-2016 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

#include "test-double.h"
#include "test-math-no-inline.h"
#include "test-math-vector.h"

#define TEST_MSG "testing double vector math (without inline functions)\n"

#define EXCEPTION_TESTS_double 0
#define ROUNDING_TESTS_double(MODE) ((MODE) == FE_TONEAREST)

#define VEC_SUFF _vlen2
#define VEC_LEN 2

#define FUNC_TEST(function) function ## _VEC_SUFF

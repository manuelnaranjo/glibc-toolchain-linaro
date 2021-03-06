/* Multiple versions of __memmove_chk
   All versions must be listed in ifunc-impl-list.c.
   Copyright (C) 2016 Free Software Foundation, Inc.
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

#include <sysdep.h>
#include <init-arch.h>

/* Define multiple versions only for the definition in lib and for
   DSO.  There are no multiarch memmove functions for static binaries.
 */
#if IS_IN (libc)
# ifdef SHARED
	.text
ENTRY(__memmove_chk)
	.type	__memmove_chk, @gnu_indirect_function
	LOAD_RTLD_GLOBAL_RO_RDX
# ifdef HAVE_AVX512_ASM_SUPPORT
	HAS_ARCH_FEATURE (AVX512F_Usable)
	jz	1f
	lea	__memmove_chk_avx512_no_vzeroupper(%rip), %RAX_LP
	HAS_ARCH_FEATURE (Prefer_No_VZEROUPPER)
	jnz	2f
	lea	__memmove_chk_avx512_unaligned_erms(%rip), %RAX_LP
	HAS_CPU_FEATURE (ERMS)
	jnz	2f
	lea	__memmove_chk_avx512_unaligned(%rip), %RAX_LP
	ret
# endif
1:	lea	__memmove_chk_avx_unaligned(%rip), %RAX_LP
	HAS_ARCH_FEATURE (AVX_Fast_Unaligned_Load)
	jz	L(Fast_Unaligned_Load)
	HAS_CPU_FEATURE (ERMS)
	jz	2f
	lea	__memmove_chk_avx_unaligned_erms(%rip), %RAX_LP
	ret
L(Fast_Unaligned_Load):
	lea	__memmove_chk_sse2_unaligned(%rip), %RAX_LP
	HAS_ARCH_FEATURE (Fast_Unaligned_Copy)
	jz	L(SSSE3)
	HAS_CPU_FEATURE (ERMS)
	jz	2f
	lea	__memmove_chk_sse2_unaligned_erms(%rip), %RAX_LP
	ret
L(SSSE3):
	HAS_CPU_FEATURE (SSSE3)
	jz	2f
	lea    __memmove_chk_ssse3_back(%rip), %RAX_LP
	HAS_ARCH_FEATURE (Fast_Copy_Backward)
	jnz	2f
	lea	__memmove_chk_ssse3(%rip), %RAX_LP
2:	ret
END(__memmove_chk)
# else
#  include "../memmove_chk.S"
# endif
#endif

/*
 * FreeRTOS+TCP Labs Build 150406 (C) 2015 Real Time Engineers ltd.
 * Authors include Hein Tibosch and Richard Barry
 *
 *******************************************************************************
 ***** NOTE ******* NOTE ******* NOTE ******* NOTE ******* NOTE ******* NOTE ***
 ***                                                                         ***
 ***                                                                         ***
 ***   FREERTOS+TCP IS STILL IN THE LAB:                                     ***
 ***                                                                         ***
 ***   This product is functional and is already being used in commercial    ***
 ***   products.  Be aware however that we are still refining its design,    ***
 ***   the source code does not yet fully conform to the strict coding and   ***
 ***   style standards mandated by Real Time Engineers ltd., and the         ***
 ***   documentation and testing is not necessarily complete.                ***
 ***                                                                         ***
 ***   PLEASE REPORT EXPERIENCES USING THE SUPPORT RESOURCES FOUND ON THE    ***
 ***   URL: http://www.FreeRTOS.org/contact  Active early adopters may, at   ***
 ***   the sole discretion of Real Time Engineers Ltd., be offered versions  ***
 ***   under a license other than that described below.                      ***
 ***                                                                         ***
 ***                                                                         ***
 ***** NOTE ******* NOTE ******* NOTE ******* NOTE ******* NOTE ******* NOTE ***
 *******************************************************************************
 *
 * - Open source licensing -
 * While FreeRTOS+TCP is in the lab it is provided only under version two of the
 * GNU General Public License (GPL) (which is different to the standard FreeRTOS
 * license).  FreeRTOS+TCP is free to download, use and distribute under the
 * terms of that license provided the copyright notice and this text are not
 * altered or removed from the source files.  The GPL V2 text is available on
 * the gnu.org web site, and on the following
 * URL: http://www.FreeRTOS.org/gpl-2.0.txt.  Active early adopters may, and
 * solely at the discretion of Real Time Engineers Ltd., be offered versions
 * under a license other then the GPL.
 *
 * FreeRTOS+TCP is distributed in the hope that it will be useful.  You cannot
 * use FreeRTOS+TCP unless you agree that you use the software 'as is'.
 * FreeRTOS+TCP is provided WITHOUT ANY WARRANTY; without even the implied
 * warranties of NON-INFRINGEMENT, MERCHANTABILITY or FITNESS FOR A PARTICULAR
 * PURPOSE. Real Time Engineers Ltd. disclaims all conditions and terms, be they
 * implied, expressed, or statutory.
 *
 * 1 tab == 4 spaces!
 *
 * http://www.FreeRTOS.org
 * http://www.FreeRTOS.org/plus
 * http://www.FreeRTOS.org/labs
 *
 */

#ifndef FREERTOS_ERRNO_TCP
#define FREERTOS_ERRNO_TCP

/* The following definitions will be included in the core FreeRTOS code in
future versions of FreeRTOS - hence the 'pd' (ProjDefs) prefix - at which time
this file will be removed. */

/* The following errno values are used by FreeRTOS+ components, not FreeRTOS
itself. */

/* For future compatibility (see comment above), check the definitions have not
already been made. */
#ifndef pdFREERTOS_ERRNO_NONE
	#define pdFREERTOS_ERRNO_NONE			0	/* No errors */
	#define	pdFREERTOS_ERRNO_ENOENT			2	/* No such file or directory */
	#define	pdFREERTOS_ERRNO_EIO			5	/* I/O error */
	#define	pdFREERTOS_ERRNO_ENXIO			6	/* No such device or address */
	#define	pdFREERTOS_ERRNO_EBADF			9	/* Bad file number */
	#define	pdFREERTOS_ERRNO_EAGAIN			11	/* No more processes */
	#define	pdFREERTOS_ERRNO_EWOULDBLOCK	11	/* Operation would block */
	#define	pdFREERTOS_ERRNO_ENOMEM			12	/* Not enough memory */
	#define	pdFREERTOS_ERRNO_EACCES			13	/* Permission denied */
	#define	pdFREERTOS_ERRNO_EFAULT			14	/* Bad address */
	#define	pdFREERTOS_ERRNO_EBUSY			16	/* Mount device busy */
	#define	pdFREERTOS_ERRNO_EEXIST			17	/* File exists */
	#define	pdFREERTOS_ERRNO_EXDEV			18	/* Cross-device link */
	#define	pdFREERTOS_ERRNO_ENODEV			19	/* No such device */
	#define	pdFREERTOS_ERRNO_ENOTDIR		20	/* Not a directory */
	#define	pdFREERTOS_ERRNO_EISDIR			21	/* Is a directory */
	#define	pdFREERTOS_ERRNO_EINVAL			22	/* Invalid argument */
	#define	pdFREERTOS_ERRNO_ENOSPC			28	/* No space left on device */
	#define	pdFREERTOS_ERRNO_ESPIPE			29	/* Illegal seek */
	#define	pdFREERTOS_ERRNO_EROFS			30	/* Read only file system */
	#define	pdFREERTOS_ERRNO_EUNATCH		42	/* Protocol driver not attached */
	#define	pdFREERTOS_ERRNO_EBADE			50	/* Invalid exchange */
	#define	pdFREERTOS_ERRNO_EFTYPE			79	/* Inappropriate file type or format */
	#define	pdFREERTOS_ERRNO_ENMFILE		89	/* No more files */
	#define	pdFREERTOS_ERRNO_ENOTEMPTY		90	/* Directory not empty */
	#define	pdFREERTOS_ERRNO_ENAMETOOLONG 	91	/* File or path name too long */
	#define	pdFREERTOS_ERRNO_EOPNOTSUPP		95	/* Operation not supported on transport endpoint */
	#define	pdFREERTOS_ERRNO_ENOBUFS		105	/* No buffer space available */
	#define	pdFREERTOS_ERRNO_ENOPROTOOPT	109	/* Protocol not available */
	#define	pdFREERTOS_ERRNO_EADDRINUSE		112	/* Address already in use */
	#define	pdFREERTOS_ERRNO_ETIMEDOUT		116	/* Connection timed out */
	#define	pdFREERTOS_ERRNO_EINPROGRESS	119	/* Connection already in progress */
	#define	pdFREERTOS_ERRNO_EALREADY		120	/* Socket already connected */
	#define	pdFREERTOS_ERRNO_EADDRNOTAVAIL 	125	/* Address not available */
	#define	pdFREERTOS_ERRNO_EISCONN		127	/* Socket is already connected */
	#define	pdFREERTOS_ERRNO_ENOTCONN		128	/* Socket is not connected */
	#define	pdFREERTOS_ERRNO_ENOMEDIUM		135	/* No medium inserted */
	#define	pdFREERTOS_ERRNO_EILSEQ			138	/* An invalid UTF-16 sequence was encountered. */
	#define	pdFREERTOS_ERRNO_ECANCELED		140	/* Operation canceled. */

	/* The following endian values are used by FreeRTOS+ components, not FreeRTOS
	itself. */
	#define pdFREERTOS_LITTLE_ENDIAN	0
	#define pdFREERTOS_BIG_ENDIAN		1

#endif /* pdFREERTOS_ERRNO_NONE */

#endif /* FREERTOS_ERRNO_TCP */




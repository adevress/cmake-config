#  find LIBHDF5 Library
# -------------------------
#
# INPUTS
# 
#
# OUTPUTS
#  LIBHDF5_DEFINITIONS		compiler flags for compiling with LIBHDF5
#  LIBHDF5_INCLUDE_DIRS		where to find hdf5.h
#  LIBHDF5_C_LIBRARIES		main C library needed to use LIBHDF5
#  LIBHDF5_C_HL_LIBRARIES	High Level C library needed to use LIBHDF5
#  LIBHDF5_CXX_LIBRARIES	CXX bindings if available
#  LIBHDF5_CXX_HL_LIBRARIES	CXX bindings for HL API if available
#  LIBHDF5_LIBRARIES		All libraries and dependencies for HDF5
#  LIBHDF5_FOUND		if false, do not try to use LIBHDF5
#
#


include(FindPackageHandleStandardArgs)



IF(LIBHDF5_INCLUDE_DIRS AND LIBHDF5_LIBRARIES)
    SET(LIBHDF5_FOUND TRUE)
ELSE()

    FIND_PATH(LIBHDF5_INCLUDE_DIRS hdf5.h
	PATHS $ENV{HDF5_ROOT}/include
    )

    FIND_LIBRARY(LIBHDF5_C_LIBRARIES NAMES libhdf5 hdf5
	    HINTS $ENV{HDF5_ROOT}
   )

   GET_FILENAME_COMPONENT(_libhdf5_libdir "${LIBHDF5_C_LIBRARIES}" DIRECTORY )

   FIND_LIBRARY(LIBHDF5_CXX_LIBRARIES NAMES libhdf5_cpp hdf5_cpp
	 PATHS ${_libhdf5_libdir}
     NO_DEFAULT_PATH 
   )
   
   FIND_LIBRARY(LIBHDF5_C_HL_LIBRARIES NAMES libhdf5_hl hdf5_hl
 	 PATHS ${_libhdf5_libdir}
     NO_DEFAULT_PATH  
   )

   FIND_LIBRARY(LIBHDF5_CXX_HL_LIBRARIES NAMES libhdf5_hl_cpp hdf5_hl_cpp
  	 PATHS ${_libhdf5_libdir}
     NO_DEFAULT_PATH   
    )


   LIST(APPEND _LIBHDF5_LIBRARIES ${LIBHDF5_C_LIBRARIES} ${LIBHDF5_CXX_LIBRARIES} ${LIBHDF5_C_HL_LIBRARIES} ${LIBHDF5_CXX_HL_LIBRARIES})
   FOREACH(_LIBHDF5_LIBRARY ${_LIBHDF5_LIBRARIES})
	IF(_LIBHDF5_LIBRARY)
		LIST(APPEND LIBHDF5_LIBRARIES ${_LIBHDF5_LIBRARY})
	ENDIF()
   ENDFOREACH()


   find_package_handle_standard_args(LIBHDF5  DEFAULT_MSG
                                  LIBHDF5_LIBRARIES LIBHDF5_INCLUDE_DIRS)
   
    MARK_AS_ADVANCED(LIBHDF5_INCLUDE_DIR LIBHDF5_LIBRARIES)
ENDIF()



# * Find mysqlclient Find the native MySQL includes and library
#
# MYSQL_INCLUDE_DIR - where to find mysql.h, etc. MYSQL_LIBRARIES   - List of
# libraries when using MySQL. MYSQL_FOUND       - True if MySQL found.

if(MYSQL_INCLUDE_DIR)
  # Already in cache, be silent
  set(MYSQL_FIND_QUIETLY TRUE)
endif(MYSQL_INCLUDE_DIR)

if(WIN32)
  find_path(MYSQL_INCLUDE_DIR mysql.h $ENV{PROGRAMFILES}/MySQL/*/include
            $ENV{SYSTEMDRIVE}/MySQL/*/include)
else(WIN32)
  find_path(
    MYSQL_INCLUDE_DIR mysql.h /usr/local/Cellar/mysql@8.0/*/include/mysql
    /opt/homebrew/include/mysql /usr/local/include/mysql /usr/include/mysql)
endif(WIN32)

set(MYSQL_NAMES mysqlclient)
if(WIN32)
  find_library(
    MYSQL_LIBRARY
    NAMES ${MYSQL_NAMES}
    PATHS $ENV{PROGRAMFILES}/MySQL/*/lib $ENV{SYSTEMDRIVE}/MySQL/*/lib
    PATH_SUFFIXES mysql)
else(WIN32)
  find_library(
    MYSQL_LIBRARY
    NAMES ${MYSQL_NAMES}
    PATHS /usr/lib /usr/local/lib /opt/homebrew/lib
          /usr/local/Cellar/mysql@8.0/*/lib
    PATH_SUFFIXES mysql)
endif(WIN32)

if(MYSQL_INCLUDE_DIR AND MYSQL_LIBRARY)
  set(MYSQL_FOUND TRUE)
  set(MYSQL_LIBRARIES ${MYSQL_LIBRARY})
else(MYSQL_INCLUDE_DIR AND MYSQL_LIBRARY)
  set(MYSQL_FOUND FALSE)
  set(MYSQL_LIBRARIES)
endif(MYSQL_INCLUDE_DIR AND MYSQL_LIBRARY)

if(MYSQL_FOUND)
  if(NOT MYSQL_FIND_QUIETLY)
    message(STATUS "Found MySQL: ${MYSQL_LIBRARY}")
  endif(NOT MYSQL_FIND_QUIETLY)
else(MYSQL_FOUND)
  if(MYSQL_FIND_REQUIRED)
    message(STATUS "Looked for MySQL libraries named ${MYSQL_NAMES}.")
    message(FATAL_ERROR "Could NOT find MySQL library")
  endif(MYSQL_FIND_REQUIRED)
endif(MYSQL_FOUND)

mark_as_advanced(MYSQL_LIBRARY MYSQL_INCLUDE_DIR)

include(CMakeParseArguments)

function(add_example)
	set(OPTIONS "")
	set(VAL_ARGS "TARGET")
	set(LST_ARGS "SOURCES")
	cmake_parse_arguments(PA "${OPTIONS}" "${VAL_ARGS}" "${LST_ARGS}" "${ARGN}")

	message(STATUS "Adding example ${PA_TARGET} with sources ${PA_SOURCES}")

	foreach(SOURCE IN LISTS PA_SOURCES)
		list(APPEND SOURCES "${PROJECT_SOURCE_DIR}/src/${SOURCE}")
	endforeach()
	set(PA_SOURCES ${SOURCES})

	add_executable(
	  ${PA_TARGET}
	  ${PA_SOURCES}
	)

	add_sycl_to_target(
	  TARGET ${PA_TARGET}
	  SOURCES ${PA_SOURCES}
	)

	add_test(
	  NAME ${PA_TARGET}
	  COMMAND ${PA_TARGET}
	)

	install(
	  TARGETS ${PA_TARGET}
	  RUNTIME DESTINATION bin
	)

endfunction()
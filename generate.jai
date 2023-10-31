#import "Bindings_Generator";
#import "Basic";
#import "File";
#import "String";
#import "BuildCpp";
#import "File_Utilities";

#run {
    using opts: Generate_Bindings_Options;
    array_add(*system_include_paths, GENERATOR_DEFAULT_SYSTEM_INCLUDE_PATH);

    array_add(*libpaths, "bin/win");
    array_add(*libnames, "fmodstudio");
    array_add(*include_paths, tprint("%fmod/core/include", #filepath));
    array_add(*include_paths, tprint("%fmod/studio/include", #filepath));

    core_files := file_list(tprint("%fmod/core/include", #filepath), true);
    for file: core_files {
        print("%\n", file);
        array_add(*source_files, file);
    }

    studio_files := file_list(tprint("%fmod/studio/include", #filepath), true);
    for file: studio_files {
        print("%\n", file);
        array_add(*source_files, file);
    }

    array_add(*extra_clang_arguments, "-x", "c++");
    generate_compile_time_struct_checks = false;

    array_add(*extra_clang_arguments, "-DDLL_EXPORTS");

    array_add(*system_include_paths, "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.22621.0\\ucrt");
    array_add(*system_include_paths, "C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Tools\\MSVC\\14.31.31103\\include");

    // visitor = my_visitor;

    generate_bindings(opts, "module.jai");
}

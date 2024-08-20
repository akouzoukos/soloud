project('SoLoud', 'c', 'cpp', version : '1.0', default_options : ['c_std=c99','cpp_std=c++17'])

sources = files(
    'src' / 'core' / 'soloud_audiosource.cpp',
    'src' / 'core' / 'soloud_bus.cpp',
    'src' / 'core' / 'soloud_core_3d.cpp',
    'src' / 'core' / 'soloud_core_basicops.cpp',
    'src' / 'core' / 'soloud_core_faderops.cpp',
    'src' / 'core' / 'soloud_core_filterops.cpp',
    'src' / 'core' / 'soloud_core_getters.cpp',
    'src' / 'core' / 'soloud_core_setters.cpp',
    'src' / 'core' / 'soloud_core_voicegroup.cpp',
    'src' / 'core' / 'soloud_core_voiceops.cpp',
    'src' / 'core' / 'soloud.cpp',
    'src' / 'core' / 'soloud_fader.cpp',
    'src' / 'core' / 'soloud_fft.cpp',
    'src' / 'core' / 'soloud_fft_lut.cpp',
    'src' / 'core' / 'soloud_file.cpp',
    'src' / 'core' / 'soloud_filter.cpp',
    'src' / 'core' / 'soloud_misc.cpp',
    'src' / 'core' / 'soloud_queue.cpp',
    'src' / 'core' / 'soloud_thread.cpp',
    'src' / 'filter' / 'soloud_bassboostfilter.cpp',
    'src' / 'filter' / 'soloud_biquadresonantfilter.cpp',
    'src' / 'filter' / 'soloud_dcremovalfilter.cpp',
    'src' / 'filter' / 'soloud_duckfilter.cpp',
    'src' / 'filter' / 'soloud_echofilter.cpp',
    'src' / 'filter' / 'soloud_eqfilter.cpp',
    'src' / 'filter' / 'soloud_fftfilter.cpp',
    'src' / 'filter' / 'soloud_flangerfilter.cpp',
    'src' / 'filter' / 'soloud_freeverbfilter.cpp',
    'src' / 'filter' / 'soloud_lofifilter.cpp',
    'src' / 'filter' / 'soloud_robotizefilter.cpp',
    'src' / 'filter' / 'soloud_waveshaperfilter.cpp',
    'src' / 'audiosource' / 'wav' / 'soloud_wav.cpp',
    'src' / 'audiosource' / 'wav' / 'soloud_wavstream.cpp',
    'src' / 'audiosource' / 'wav' / 'stb_vorbis.c',
    'src' / 'audiosource' / 'wav' / 'dr_impl.cpp',
    'src' / 'audiosource' / 'openmpt' / 'soloud_openmpt.cpp',
    'src' / 'audiosource' / 'openmpt' / 'soloud_openmpt_dll.c',
    'src' / 'backend' / 'sdl' / 'soloud_sdl2.cpp',
)

opus = dependency('opus', fallback : ['opus', 'opus_dep'])
ogg = dependency('ogg', fallback : ['ogg', 'libogg_dep'])
openmpt = dependency('openmpt', default_options : ['default_library=static'], fallback : ['openmpt', 'openmpt_dep'])

deps = [
    ogg,
    opus,
    openmpt,
]

if get_option('portmaster')
    sources += files('src/backend/sdl/soloud_sdl2_dll.c')
    arg = '-DWITH_SDL2=1'
    deps += dependency('sdl2', static : false, default_options : ['default_library=shared'], fallback : ['sdl2', 'sdl2_dep'])
    deps += dependency('dl', static : true)
else
    sources += files('src/backend/sdl2_static/soloud_sdl2_static.cpp')
    arg = '-DWITH_SDL2_STATIC=1'
    deps += dependency('sdl2', static : true, default_options : ['default_library=static'], fallback : ['sdl2', 'sdl2_dep'])
endif

link_args = []

inc = include_directories('include')

args = [
    '-O3',
    '-fpic',
    '-fpie',
    arg,
]

lib = static_library(
    'SoLoud',
    sources,
    dependencies : deps,
    include_directories : inc,
    link_args: link_args,
    c_args : args,
    cpp_args: args
)

soloud_dep = declare_dependency(link_with : lib, include_directories : inc)

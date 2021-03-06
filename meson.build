project('com.github.friendofentropy.postapocrpgtools', 'vala', 'c', version: '0.1.0')

gnome = import('gnome')

add_global_arguments ('-DGETTEXT_PACKAGE="' + meson.project_name () + '"', language:'c')

code_resources = gnome.compile_resources(
    'code-resources', 'data/' + meson.project_name() + '.gresource.xml',
    source_dir: 'data',
)

glib_dep = dependency('glib-2.0', version: '>=2.30.0')
gio_dep = dependency('gio-2.0', version: '>=2.26')
gee_dep = dependency('gee-0.8', version: '>=0.8')
gtk_dep = dependency('gtk+-3.0', version: '>=3.6.0')
webkit2gtk_dep = dependency('webkit2gtk-4.0', version: '>= 2.20.5')
gsl_dep = dependency ('gsl')
granite_dep = dependency ('granite')
json_dep = dependency ('json-glib-1.0', version: '>=1.0')


code_files = files(
    'src/Application.vala',
    'src/Constants.vala',
    'src/MainWindow.vala',
    'src/renderers/AbstractHTMLRenderer.vala',
    'src/renderers/CharacterHTMLRenderer.vala',
    'src/views/CharacterGeneratorView.vala'
)

# librpgcore subproject via git submodule
librpgcore = subproject('librpgcore')
librpgcore_sp_dep = librpgcore.get_variable('lib_dep')

dependencies = [
    glib_dep,
    gio_dep,
    gee_dep,
    gtk_dep,
    gsl_dep,
    granite_dep,
    webkit2gtk_dep,
    json_dep,
    librpgcore_sp_dep
]

executable(
    meson.project_name(),
    code_files,
    code_resources,
    dependencies: dependencies,
    install: true
)

subdir('data')

meson.add_install_script('meson/post_install.py')
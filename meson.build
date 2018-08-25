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

dependencies = [
    glib_dep,
    gio_dep,
    gee_dep,
    gtk_dep,
    gsl_dep,
    granite_dep,
    webkit2gtk_dep
]

code_files = files(
    'src/Application.vala'
)

executable(
    meson.project_name(),
    code_files,
    code_resources,
    dependencies: dependencies,
    install: true
)

subdir('data')

#meson.add_install_script('meson/post_install.py')
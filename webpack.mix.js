const mix = require('laravel-mix');

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */
//mix.setResourceRoot('public/');

mix.js('resources/js/app.js', 'public/js')
    .sass('resources/sass/app.scss', 'public/css');
mix.setResourceRoot('/myself/api_portal/public/');
/*mix.scripts([
    'public/js/custom/custom.js',
], 'public/js/all.js');

mix.styles([
    'public/css/custom/custom.css'
], 'public/css/all.css');*/

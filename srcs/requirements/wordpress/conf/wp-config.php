<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress'); //getenv('MARIADB_DATABASE'));

/** Database username */
define( 'DB_USER', 'dbuser'); // getenv('DB_USER'));

/** Database password */
define( 'DB_PASSWORD', 'hello2000'); // getenv('DB_PASSWORD')); TODO change!!

/** Database hostname */
define( 'DB_HOST', 'mariadb') ; // getenv('DB_HOST'));

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

# define( 'DB_HOME', 'https://localhost' ); // TODO check if necessary
# define( 'DB_SITEURL', 'https://localhost' );


/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '_3[H_Ivnm|2z*:T`Tn#@{Ic[AY~N]cs I,=.(-&`TAQ-v.oef,**hMGQ:7S;/W?|');
define('SECURE_AUTH_KEY',  'w-lvA>>iUKqp|TkWkI@?p[L9[q?uN]?zrXCNE#`/Ml|M+Zi9:7(eyG:oQs=:xy{!');
define('LOGGED_IN_KEY',    '+xmT^zU+{[~T]QWg1kLx(Ce]NXgyAb^!*|IT:0-/GyN.XSR[-AfN4Tyn}8Gy;Vlx');
define('NONCE_KEY',        'ckn-j4/|mFj??jqJhPV[sprk~ SUn2q##65Tl ZlMQ-W5?CbA2s[ZHH!nbs[SJ+S');
define('AUTH_SALT',        'DJJ5`9Pl-{W8)pE<nZ-tOb&9;[ M4LP~eSDFf1[8Et&|FD_D`9G4MR6,PL.,kiOu');
define('SECURE_AUTH_SALT', 'CHWkfr1m)lZRRy] Mr+=JXC$t|Z,45YD~UeNo~j+uY3]&K&-6UZWsPT:fpOYi66<');
define('LOGGED_IN_SALT',   'v/LHi{6W,e?Dr5Ln<_2(7aa@9,-4u^CI_@-fd?X ~1ZeTauND#AHC1G@=eoYEcVr');
define('NONCE_SALT',       '^yV}($[h,pm98)a!#o-[,lK6,3N%$fDqOf@-nUxV*=1=thp-s.|9SRSw+ve!tGU~');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

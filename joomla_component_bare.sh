#!/usr/bin/env bash
#create skeletal joomla component
# Albert Sharkis
# sharkis@sharkzilatechnologies.com
# github.com/sharkis

if [ -z "$5" ]; then
	echo "usage: $0 component_name author_name author_email author_url copyright_info"
	exit 1
fi;
COM_NAME="$1"
AUTHOR_NAME="$2"
AUTHOR_EMAIL="$3"
AUTHOR_URL="$4"
COPYRIGHT="$5"
CREATE_DATE=`date '+%B %Y'`
COPY_YEAR=`date '+%Y'`
echo "Creating joomla component com_$COM_NAME"
mkdir -p admin/controllers
mkdir admin/helpers
mkdir -p admin/language/en-GB
mkdir -p admin/models/forms
mkdir -p admin/sql/updates/mysql
mkdir admin/tables
mkdir -p "admin/views/$COM_NAME/tmpl"
mkdir -p site/controllers
mkdir -p site/language/en-GB
mkdir site/models
mkdir -p "site/views/$COM_NAME/tmpl"
mkdir media
cat > "$COM_NAME.xml" << EOF 
<?xml version="1.0" encoding="utf-8"?>
<extension type="component" version="3.5.0" method="upgrade">
	<name>COM_$COM_NAME</name>
	<creationDate>$CREATE_DATE</creationDate>
	<author>$AUTHOR_NAME</author>
	<authorEmail>$AUTHOR_EMAIL</authorEmail>
	<authorUrl>$AUTHOR_URL</authorUrl>
	<copyright>(c) $COPY_YEAR $COPYRIGHT</copyright>
	<license>TBD</license>
	<version>0.0.1</version>
	<description>COM_${COM_NAME}_DESC</description>
	<install>
		<sql>
			<file driver="mysql" charset="utf8">sql/install.mysql/utf8.sql</file>
		</sql>
	</install>
	<uninstall>
		<sql>
			<file driver="mysql" charset="utf8">sql/uninstall.mysql/utf8.sql</file>
		</sql>
	</uninstall>
	<update>
		<schemas>
			<schemapath type="mysql">sql/updates/mysql</schemapath>
		</schemas>
	</update>
	
	<files folder="site">
		<filename>index.html</filename>
		<filename>${COM_NAME}.php</filename>
		<filename>controller.php</filename>
		<folder>controllers</folder>
		<folder>views</folder>
		<folder>models</folder>
	</files>	
	<media folder="media">
		<filename>index.html</filename>
		<folder>com_$COM_NAME</folder>
	</media>

	<languages folder="site/language">
		<language tag="en-GB">en-GB/en-GB.com_${COM_NAME}.ini</language>
	</languages>

	<administration>
		<menu link='index.php?option=com_$COM_NAME'>COM_${COM_NAME}_MENU</menu>
		<files folder="admin">
			<filename>index.html</filename>
			<filename>${COM_NAME}.php</filename>
			<filename>controller.php</filename>
			<folder>views</folder>
			<folder>helpers</folder>
			<folder>controllers</folder>
			<folder>sql</folder>
			<folder>tables</folder>
			<folder>models</folder>
		</files>
		<languages folder="admin/language">
			<language tag="en-GB">en-GB/en-GB.com_${COM_NAME}.ini</language>
			<language tag="en-GB">en-GB/en-GB.com_${COM_NAME}.sys.ini</language>
		</languages>
	</administration>
</extension>
EOF
cat > index.html << EOF 
<html><head><title>Direct access denied</title></head><body>Direct access denied</body></html>
EOF
find . -type d -exec cp index.html {} \;
touch admin/sql/install.mysql.utf8.sql
touch admin/sql/uninstall.mysql.utf8.sql
touch admin/sql/updates/mysql/0.0.1.sql
cat > admin/language/en-GB/en-GB.com_${COM_NAME}.sys.ini << EOF 
; Joomla! system strings
COM_$COM_NAME=""
COM_${COM_NAME}_DESC=""
COM_${COM_NAME}_MENU=""
EOF
touch admin/language/en-GB/en-GB.com_${COM_NAME}.ini
touch site/language/en-GB/en-GB.com_${COM_NAME}.ini

#!/usr/bin/env bash
# create skeletal joomla component
# Albert Sharkis
# sharkis@sharkis.org
# github.com/sharkis

if [ -z "$5" ]; then
	echo "usage: $0 component_name author_name author_email author_url copyright_info"
	exit 1
fi;
COM_NAME=`echo $1 | sed 's/\w*/\L&/'` #lowercase
COM_NAME_TITLECASE=`echo ${COM_NAME} | sed 's/\W//g; s/.*/\L&/; s/[a-z]*/\u&/g'`
COM_NAME_UPPER=`echo ${COM_NAME} | sed 's/\w*/\U&/'`
AUTHOR_NAME="$2"
AUTHOR_EMAIL="$3"
AUTHOR_URL="$4"
COPYRIGHT="$5"
CREATE_DATE=`date '+%B %Y'`
COPY_YEAR=`date '+%Y'`
echo "Creating joomla component com_$COM_NAME"
mkdir -p com_${COM_NAME}/admin/controllers com_${COM_NAME}/admin/helpers com_${COM_NAME}/admin/language/en-GB com_${COM_NAME}/admin/models/forms com_${COM_NAME}/admin/sql/updates/mysql com_${COM_NAME}/admin/tables "com_${COM_NAME}/admin/views/$COM_NAME/tmpl" com_${COM_NAME}/site/controllers com_${COM_NAME}/site/language/en-GB com_${COM_NAME}/site/models "com_${COM_NAME}/site/views/$COM_NAME/tmpl" com_${COM_NAME}/media/com_${COM_NAME}
cat > com_${COM_NAME}/$COM_NAME.xml << EOF 
	<?xml version="1.0" encoding="utf-8"?>
	<extension type="component" version="3.5.0" method="upgrade">
		<name>COM_$COM_NAME_UPPER</name>
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
				<file driver="mysql" charset="utf8">sql/install.mysql.utf8.sql</file>
			</sql>
		</install>
		<uninstall>
			<sql>
				<file driver="mysql" charset="utf8">sql/uninstall.mysql.utf8.sql</file>
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
cat > "com_${COM_NAME}/index.html" << EOF 
<html><head><title>Direct access denied</title></head><body>Direct access denied</body></html>
EOF
find com_${COM_NAME}/ -type d -exec cp com_${COM_NAME}/index.html {} \;
touch com_${COM_NAME}/admin/sql/install.mysql.utf8.sql
touch com_${COM_NAME}/admin/sql/uninstall.mysql.utf8.sql
touch com_${COM_NAME}/admin/sql/updates/mysql/0.0.1.sql
touch com_${COM_NAME}/admin/${COM_NAME}.php
touch com_${COM_NAME}/site/${COM_NAME}.php
touch com_${COM_NAME}/admin/controller.php
touch com_${COM_NAME}/site/controller.php
cat > com_${COM_NAME}/admin/language/en-GB/en-GB.com_${COM_NAME}.sys.ini << EOF 
	; Joomla! system strings
	COM_$COM_NAME_UPPER=""
	COM_${COM_NAME_UPPER}_DESC=""
	COM_${COM_NAME_UPPER}_MENU=""
EOF
touch com_${COM_NAME}/admin/language/en-GB/en-GB.com_${COM_NAME}.ini
touch com_${COM_NAME}/site/language/en-GB/en-GB.com_${COM_NAME}.ini
cat > makefile << EOF
all: component
component:	
	@zip -qr com_${COM_NAME}.zip com_${COM_NAME}/ -x "*.git" -x "*.swp" -x "*.zip" && echo "Successfully packaged ${COM_NAME_TITLECASE} component."
EOF
cat > com_${COM_NAME}/admin/mvc.sh << EOS
#!/usr/bin/env bash
#create skeletal models, views, and controllers
for i in "\${@}"
do
#admin controllers
VIEW_NAME_TITLECASE=\`echo \$i | sed 's/\W//g; s/.*/\L&/; s/[a-z]*/\u&/g'\`
cat > ./controllers/\$i.php << EOF
<?php defined("_JEXEC") or die();
class ${COM_NAME_TITLECASE}Controller\$VIEW_NAME_TITLECASE extends JControllerForm{
	
}
EOF
cat > ./controllers/\${i}s.php << EOF
<?php defined("_JEXEC") or die();
class ${COM_NAME_TITLECASE}Controller\${VIEW_NAME_TITLECASE}s extends JControllerAdmin{
	public function getModel(\\\$name='\${VIEW_NAME_TITLECASE}',\\\$prefix='${COM_NAME_TITLECASE}Model',\\\$config=array('ignore_request'=>true)){
		\\\$model = parent::getModel(\\\$name,\\\$prefix,\\\$config);
		return \\\$model;
	}
}
EOF
cat > ./models/\$i.php << EOF
<?php defined("_JEXEC") or die();
class ${COM_NAME_TITLECASE}Model\$VIEW_NAME_TITLECASE extends JModelAdmin{
	public function getTable(\\\$type='\${VIEW_NAME_TITLECASE}',\\\$prefix='${COM_NAME_TITLECASE}Table',\\\$config=array()){
		return JTable::getInstance(\\\$type,\\\$prefix,\\\$config);
	}

	public function getForm(\\\$data=array(),\\\$loadData=true){
		\\\$form = \\\$this->loadForm('com_${COM_NAME}.\${i}','\${i}',array('control'=>'jform','load_data'=>\\\$loadData));
		if(empty(\\\$form)){
			return false;
		}
		return \\\$form;
	}

	protected function loadFormData(){
		\\\$data = JFactory::getApplication()->getUserState('com_${COM_NAME}.edit.\${i}.data',array());
		if(empty(\\\$data)){
			\\\$data = \\\$this->getItem();
		}
		return \\\$data;
	}
}
EOF
cat > ./models/\${i}s.php << EOF
<?php defined("_JEXEC") or die();
class ${COM_NAME_TITLECASE}Model\${VIEW_NAME_TITLECASE}s extends JModelList{
	public function __construct(\\\$config=array()){
		if(empty(\\\$config['filter_fields'])){
			\\\$config['filter_fields']=array();
		}
		parent::__construct(\\\$config);
	}

	public function getListQuery(){
		\\\$db = JFactory::getDbo();
		\\\$query = \\\$db->getQuery(true);
		\\\$query->select('*')
			->from('#__${COM_NAME}_\${i}s');
		return \\\$query;
	}

	public function populateState(\\\$ordering='id',\\\$direction='asc'){
		parent::populateState(\\\$ordering,\\\$direction);
		
	}
}
EOF
#views
mkdir -p ./views/\${i}/tmpl
cat > ./views/\${i}/view.html.php << EOF
<?php defined("_JEXEC") or die();
class ${COM_NAME_TITLECASE}View\$VIEW_NAME_TITLECASE extends JViewLegacy{
	public function display(\\\$tpl=null){
		parent::display(\\\$tpl);
	}
}
EOF
cat > ./views/\${i}/tmpl/default.php << EOF
<?php defined("_JEXEC") or die();?>
EOF
mkdir -p ./views/\${i}s/tmpl
cat > ./views/\${i}s/view.html.php << EOF
<?php defined("_JEXEC") or die();
class ${COM_NAME_TITLECASE}View\${VIEW_NAME_TITLECASE}s extends JViewLegacy{
	public function display(\\\$tpl=null){
		parent::display(\\\$tpl);
	}
}
EOF
cat > ./views/\${i}s/tmpl/default.php << EOF
<?php defined("_JEXEC") or die();?>
EOF
done
EOS

import os
import datetime
import subprocess
import requests
import smtplib
from email.mime.text import MIMEText
from email.header import Header

# config the build settings
CONFIGURATION = 'Release'
SDK = "iphoneos"
WORKSPACE = "DaCongMing.xcworkspace"
TARGET = "DaCongMing"
SCHEME = "DaCongMing"
XCARCHIVE_NAME = TARGET + '.xcarchive'

PROJECT_PATH = '~/Desktop/DaCongMing/DaCongMing'
EXPORT_DIRECTORY = '~/desktop/IPA'
APP_PATH = os.getcwd() + '/build/' + CONFIGURATION + '-iphoneos'
APP_FILE_NAME = APP_PATH + TARGET + '.app'
KEYCHAIN_PATH = '~/Library/Keychains/login.keychain'
KEYCHAIN_PWD = 'hailin998'

EXPORT_APP_STORE_PLIST = 'AppStoreOptions.plist'
EXPORT_ADHOC_PLIST = 'AdhocOptions.plist'
PGYER_UPLOAD_URL = "http://www.pgyer.com/apiv1/app/upload"
DOWNLOAD_BASE_URL = "http://www.pgyer.com"
PGYER_API_KEY = 'f3098742d56ea1dbe66af5d36f46501b'
PGYER_USER_KEY = 'd9969dac94b5d66af2d91e513e4c43c1'
PGYER_APP_KEY = 'cf1418ec3e1cfb9b806c76c2c69d9cb2'
PGYER_APP_ID = ''

SENDER_EMAIL = 'huyong229@163.com'
RECEIVER_EMAIL = '229376483@qq.com'


# clean项目
def clean_project():
    print('clean project')
    os.system('cd %s; xcodebuild clean' % PROJECT_PATH)
    show_notification('clean成功', '正在运行clean方法')
    return


# build编译
def build_project():

    archive_path = PROJECT_PATH + '/build/' + XCARCHIVE_NAME
    build_commond = 'cd %s; xcodebuild archive -workspace %s -scheme %s -sdk %s -configuration %s' \
                    ' -archivePath %s' \
                    % (PROJECT_PATH, WORKSPACE, SCHEME, SDK, CONFIGURATION, archive_path)
    print(build_commond)
    os.system('xcodebuild -list')
    os.system(build_commond)
    show_notification('正在编译中', '别着急，正在编译')
    print('the path of xcarchive is %s' % archive_path)
    archive_ipa(archive_path)


# 打包
def archive_ipa(archive_path):
    current_date = datetime.datetime.now().strftime("%Y-%m-%d~%H-%M-%S")
    ipa_path = '%s/%s~%s' % (EXPORT_DIRECTORY, SCHEME, current_date)
    print(ipa_path)
    # 如果不存在文件夹，则创建
    if not os.path.isdir(ipa_path):
        os.system('mkdir %s' % ipa_path)
    ipa_export_path = ipa_path + '/'
    export_option_plist = PROJECT_PATH + '/' + EXPORT_ADHOC_PLIST
    archive_commmand = 'xcodebuild -exportArchive  -archivePath %s -exportPath %s -exportOptionsPlist %s' \
                       % (archive_path, ipa_export_path, export_option_plist)
    print(archive_commmand)
    show_notification('正在打包中', '别着急，正在打包')
    os.system(archive_commmand)
    ipa_file_name = ipa_export_path + TARGET + '.ipa'
    # 删除archive文件
    os.remove(XCARCHIVE_NAME)
    upload_pgyer(ipa_file_name)


# 解析上传蒲公英的结果
def parser_upload_result(json_result):
    result_code = json_result['code']
    if result_code == 0:
        download_url = DOWNLOAD_BASE_URL + "/" + json_result['data']['appShortcutUrl']
        print('upload success! url is %s' % download_url)
    else:
        print('upload failed! Reason is %s' % json_result['message'])


# 上传到蒲公英
def upload_pgyer(ipa_path):
    ipa_path = os.path.expanduser(ipa_path)
    files = {'file': open(ipa_path, 'rb')}
    headers = {'enctype': 'multipart/form-data'}
    paramater = {'uKey': PGYER_USER_KEY, '_api_key': PGYER_API_KEY}
    r = requests.post(PGYER_UPLOAD_URL, data=paramater, files=files, headers=headers)
    if r.status_code == 200:
        result = r.json()
        parser_upload_result(result)
    else:
        print('上传蒲公英出现了问题，errorcode = %s' % r.status_code)


# 获取权限
def allow_keychain():
    os.system("security unlock-keychain -p '%s' %s" % (KEYCHAIN_PWD, KEYCHAIN_PATH))
    return


def show_notification(title, subtitle):
    notification = "osascript -e 'display notification \"%s\" with title \"%s\"'" % (subtitle, title)
    print(notification)
    os.system(notification)


def main():
    allow_keychain()
    clean_project()
    build_project()


if __name__ == '__main__':
    main()

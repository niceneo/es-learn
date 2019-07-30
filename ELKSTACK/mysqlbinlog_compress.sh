#/bin/sh
#
# 脚本根据ls -l指令第7列判断mysqlbinlog文件是否在前天，如果在将进行压缩归档

# 备份 2 天前的mysql bin log
day=`date "+%d" -d "-2day"`
bkfile=mysql_binlog_`date "+%Y-%m-%d-%H-%M-%S" -d "-2day"`.tar.gz
basedir=/mydata/binlog
bkdir=/mydata/binlog_compress
logs=/mydata/binlog_compress/mysqlbinlog_compress.log

filelist=`ls -l $basedir | awk -v a="$day" '{if ($7==a) print $9}'`

echo `date "+%Y-%m-%d-%H-%M-%S"` Start >> $logs
if [ "$filelist" == "" ]; then
  echo $day " file not found " >> $logs
  exit 0
fi
echo $filelist " need backup file " >> $logs
cd $basedir && tar zcf $bkdir/$bkfile $filelist --remove-files
echo `date "+%Y-%m-%d-%H-%M-%S"` Success >> $logs
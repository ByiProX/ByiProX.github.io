---
title: Java实时读取log日志文件示例代码
date: 2019-05-21 14:28:14
tags:
  - Java
categories:
  - Java
---

`需求`：正在开发一个监控系统，要求将多台日志信息实时采集出来，然后保存到Kafka中，后期对日志数据进行spark运算、大数据处理分析，日志按大小，时间切分。

`运用的技术`：RandomAccessFile类中seek方法可以从指定位置读取文件，可以用来实现文件实时读取，JDK文档有对RandomAccessFile的介绍。

`思想`：在每一次读取后，close一下就不会影响重命名操作了。因为日志是线上机器产生的，我们只需要写实时读取的方法即可，但是这里为了模拟实际情况，也把产生日志的方法出来，在测试的时候，可以手动改变日志的名称，更为方便的处理方式-----将日志mock.log直接删除即可。


模拟写日志的类
因为日志是按大小和时间切分的，在测试的时候，直接修改日志的名称，或者删除日志。
<!-- more -->

```Java
package com.inveno.file;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogSvr {

	private static final Logger logger = LoggerFactory.getLogger(LogSvr.class);

	private SimpleDateFormat  dateFormat = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
	private static ScheduledExecutorService exec = Executors.newScheduledThreadPool(1);

	public void logMsg(File logFile,String msgInfo) throws IOException{

		if(!logFile.exists()) {
			logFile.createNewFile();
		}

		Writer txtWriter = new FileWriter(logFile,true);
		txtWriter.write(dateFormat.format(new Date()) + "\t" + msgInfo + "\n");
		txtWriter.flush();
		txtWriter.close();
	}

	public void stop(){
		if(exec != null){
			exec.shutdown();
			logger.info("file write stop ！");
		}
	}

	public static void main(String[] args) throws Exception {

		final LogSvr logSvr = new LogSvr();
		final File tmpLogFile = new File("pathtolog.log");
		final String msgInfo = "test !";

		//启动一个线程每5秒向日志文件写一次数据
		exec.scheduleWithFixedDelay(new Runnable(){

			@Override
			public void run() {
				try {
					logSvr.logMsg(tmpLogFile, msgInfo);
					//Thread.sleep(1000);
				} catch (Exception e) {
					logger.error("file write error ！");
				}
			}

		}, 0, 5, TimeUnit.SECONDS);

	}

}


```java

import org.apache.log4j.Logger;

import java.io.File;
import java.io.RandomAccessFile;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class LogView {
    private static Logger logger = Logger.getLogger(Start.class.getName());

    private long pointer = 0; // 文件指针位置
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");

    private ScheduledExecutorService exec = Executors.newScheduledThreadPool(1);

    public void realtimeShowLog(final File logFile) throws Exception {

        if (logFile == null) {
            throw new IllegalStateException("logFile can not be null");
        }

        //启动一个线程每2秒读取新增的日志信息
        exec.scheduleWithFixedDelay(new Runnable() {

            public void run() {

                //获得变化部分
                try {

                    long len = logFile.length();
                    if (len < pointer) {
                        logger.info("Log file was reset. Restarting logging from start of file.");
                        pointer = 0;
                    } else {

                        //指定文件可读可写
                        RandomAccessFile randomFile = new RandomAccessFile(logFile, "rw");

                        //获取RandomAccessFile对象文件指针的位置，初始位置是0
                        logger.info("RandomAccessFile文件指针的初始位置:" + pointer);

                        randomFile.seek(pointer);//移动到文件指针位置

                        String tmp;
                        while ((tmp = randomFile.readLine()) != null) {
                            System.out.println("info : " + new String(tmp.getBytes("utf-8")));
                            pointer = randomFile.getFilePointer();
                        }

                        randomFile.close();
                    }

                } catch (Exception e) {
                    //实时读取日志异常，需要记录时间和lastTimeFileSize 以便后期手动补充
                    logger.error(dateFormat.format(new Date()) + " File read error, pointer: " + pointer);
                } finally {
                    //将pointer 落地以便下次启动的时候，直接从指定位置获取
                }
            }

        }, 0, 10, TimeUnit.SECONDS);

    }

    public void stop() {
        if (exec != null) {
            exec.shutdown();
            logger.info("file read stop ！");
        }
    }


    public static void main(String[] args) throws Exception {

        LogView view = new LogView();
        File tmpLogFile = new File("pathtolog.log");
        System.out.println(tmpLogFile.getAbsolutePath());
        view.pointer = 0;
        view.realtimeShowLog(tmpLogFile);

    }
}
```

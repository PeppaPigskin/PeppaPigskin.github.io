package com.wcc.util;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Random;
import java.util.UUID;

/**
 * CommonUtils:【blog-工具类】
 *
 * @author: WuChen
 * @create: 2020-10-23 11:31
 * @modify:
 */
public class CommonUtils {


    /**
     * 获取指定范围内的随机数
     *
     * @param minNumber 最小数
     * @param maxNumber 最大数据
     * @return
     */
    public static int getRandomNumber(int minNumber, int maxNumber) {
        Random random = new Random();
        return random.nextInt(maxNumber - minNumber + 1) + minNumber;
    }

    /**
     * 图片上传工具类
     *
     * @param request
     * @param file
     * @param path
     * @return
     */
    public static String upload(HttpServletRequest request, MultipartFile file, String path) {
        String fileName = file.getOriginalFilename();
        fileName = UUID.randomUUID() + fileName.substring(fileName.indexOf("."), fileName.length());
        File targetFile = new File(path, fileName);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }
        //保存
        try {
            file.transferTo(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileName;
    }

}

package com.letvcloud.uc.utils;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;

/**
 * Created by zhaoliang5 on 2015/7/4.
 */
public class Captcha {
    private Color bgColor = new Color(240, 127, 177);  //背景颜色
    int width = 120;
    int height = 40;
    private String codes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    public String getText(int length) {
        String text = "";
        Random random = new Random();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(codes.length());
            text += codes.charAt(index) + "";
        }
        return text;
    }

    private Color randomColor() {
        Random random = new Random();
        int r = random.nextInt(256);
        int g = random.nextInt(256);
        int b = random.nextInt(256);
        return new Color(r, g, b);
    }

    private int[] fontSizes = {24, 25, 26, 27, 28};
    private String[] fontNames = {"宋体", "华文楷体", "黑体", "华文新魏", "华文隶书", "微软雅黑", "楷体_GB2312"};

    private Font randomFont() {
        Random random = new Random();
        int index = random.nextInt(fontNames.length);
        String name = fontNames[index];

        int style = random.nextInt(4);

        index = random.nextInt(fontSizes.length);
        int size = fontSizes[index];
        return new Font(name, style, size);
    }

    private BufferedImage createImage() {
        /*
         * 1. 创建图片
		 * 2. 设置背景色
		 */
        //创建图片
        BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        //设置画笔颜色
        img.getGraphics().setColor(bgColor);
        //填充一个与图片一样大小的矩形！即设置背景色！
        img.getGraphics().fillRect(0, 0, width, height);
        return img;
    }

    public BufferedImage getImage(String text,boolean drawLine) {
        /*
         * 写什么字符：随机生成，范围：0-9、A-Z、a-z
		 * 字体：随机
		 * 字符颜色：随机
		 */
        BufferedImage img = createImage();
        Graphics g = img.getGraphics();
        //画东西
        Color color = new Color(66, 151, 26);
        for (int i = 0; i < text.length(); i++) {
            String ch = text.toCharArray()[i] + "";  //获取随机字符
            g.setColor(color);  //获取随机颜色
            g.setFont(this.randomFont());  //获取随机字体
            g.drawString(ch, width / 4 * i, height - 5);
        }
        //	this.drawLine(img);  //添加干扰线
        return img;
    }
    public BufferedImage getImage(String text) {
       return getImage(text,false);
    }

    //生成干扰线
    private void drawLine(BufferedImage img) {
        Random random = new Random();
        Graphics g = img.getGraphics();
        //Graphics2D g2d = (Graphics2D) img.getGraphics();
        g.setColor(Color.BLACK);
        //g2d.setStroke(new BasicStroke(1.5F));  //调整画笔粗细
        for (int i = 0; i < 5; i++) {
            int x1 = random.nextInt(width);
            int y1 = random.nextInt(height);
            int x2 = random.nextInt(width);
            int y2 = random.nextInt(height);
            g.drawLine(x1, y1, x2, y2);
        }
    }
}

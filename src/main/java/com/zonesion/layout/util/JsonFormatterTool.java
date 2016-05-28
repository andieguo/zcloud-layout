package com.zonesion.layout.util;

/**    
 * @author andieguo andieguo@foxmail.com
 * @Description: 将JSON字符串进行缩进格式化输出 
 * @date 2016年5月28日 下午4:06:04  
 * @version V1.0    
 */
/**
 * 该类提供格式化JSON字符串的方法。
 * 该类的方法formatJson将JSON字符串格式化，方便查看JSON数据。
 * <p>例如：
 * <p>JSON字符串：["yht","xzj","zwy"]
 * <p>格式化为：
 * <p>[
 * <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"yht",
 * <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"xzj",
 * <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"zwy"
 * <p>]
 * 
 * <p>使用算法如下：
 * <p>对输入字符串，追个字符的遍历
 * <p>1、获取当前字符。
 * <p>2、如果当前字符是前方括号、前花括号做如下处理：
 * <p>（1）如果前面还有字符，并且字符为“：”，打印：换行和缩进字符字符串。
 * <p>（2）打印：当前字符。
 * <p>（3）前方括号、前花括号，的后面必须换行。打印：换行。
 * <p>（4）每出现一次前方括号、前花括号；缩进次数增加一次。打印：新行缩进。
 * <p>（5）进行下一次循环。
 * <p>3、如果当前字符是后方括号、后花括号做如下处理：
 * <p>（1）后方括号、后花括号，的前面必须换行。打印：换行。
 * <p>（2）每出现一次后方括号、后花括号；缩进次数减少一次。打印：缩进。
 * <p>（3）打印：当前字符。
 * <p>（4）如果当前字符后面还有字符，并且字符不为“，”，打印：换行。
 * <p>（5）继续下一次循环。
 * <p>4、如果当前字符是逗号。逗号后面换行，并缩进，不改变缩进次数。
 * <p>5、打印：当前字符。
 * 
 */
public class JsonFormatterTool
{
    /**
     * 单位缩进字符串。
     */
    private static String SPACE = "   ";
    
    /**
     * 返回格式化JSON字符串。
     * 
     * @param json 未格式化的JSON字符串。
     * @return 格式化的JSON字符串。
     */
    public static String formatJson(String json)
    {
        StringBuffer result = new StringBuffer();
        
        int length = json.length();
        int number = 0;
        char key = 0;
        
        //遍历输入字符串。
        for (int i = 0; i < length; i++)
        {
            //1、获取当前字符。
            key = json.charAt(i);
            
            //2、如果当前字符是前方括号、前花括号做如下处理：
            if((key == '[') || (key == '{') )
            {
                //（1）如果前面还有字符，并且字符为“：”，打印：换行和缩进字符字符串。
                if((i - 1 > 0) && (json.charAt(i - 1) == ':'))
                {
                    result.append('\n');
                    result.append(indent(number));
                }
                
                //（2）打印：当前字符。
                result.append(key);
                
                //（3）前方括号、前花括号，的后面必须换行。打印：换行。
                result.append('\n');
                
                //（4）每出现一次前方括号、前花括号；缩进次数增加一次。打印：新行缩进。
                number++;
                result.append(indent(number));
                
                //（5）进行下一次循环。
                continue;
            }
            
            //3、如果当前字符是后方括号、后花括号做如下处理：
            if((key == ']') || (key == '}') )
            {
                //（1）后方括号、后花括号，的前面必须换行。打印：换行。
                result.append('\n');
                
                //（2）每出现一次后方括号、后花括号；缩进次数减少一次。打印：缩进。
                number--;
                result.append(indent(number));
                
                //（3）打印：当前字符。
                result.append(key);
                
                //（4）如果当前字符后面还有字符，并且字符不为“，”，打印：换行。
                if(((i + 1) < length) && (json.charAt(i + 1) != ','))
                {
                    result.append('\n');
                }
                
                //（5）继续下一次循环。
                continue;
            }
            
            //4、如果当前字符是逗号。逗号后面换行，并缩进，不改变缩进次数。
            if((key == ','))
            {
                result.append(key);
                result.append('\n');
                result.append(indent(number));
                continue;
            }
            
            //5、打印：当前字符。
            result.append(key);
        }
        
        return result.toString();
    }
    
    /**
     * 返回指定次数的缩进字符串。每一次缩进三个空格，即SPACE。
     * 
     * @param number 缩进次数。
     * @return 指定缩进次数的字符串。
     */
    private static String indent(int number)
    {
        StringBuffer result = new StringBuffer();
        for(int i = 0; i < number; i++)
        {
            result.append(SPACE);
        }
        return result.toString();
    }
    
    public static void main(String[] args) {
    	String jsonStr = "{\"name\":\"caoxinlin\",\"tid\":92,\"imageUrl\":\"meituxiuxiu.jpg\",\"zcloudID\":\"1155223953\",\"zcloudKEY\":\"Xrk6UicNrbo3KiX1tYDDaUq9HAMHBYhuE2Sb4NLKFKdNcLH5\",\"serverAddr\":\"zhiyun360.com:28080\",\"macList\":[{\"dataType\":\"realTime|history\",\"title\":\"温度历史数据\",\"address\":\"00:12:4B:00:02:CB:A8:52\",\"command\":{},\"tid\":\"hc_curve_356712\",\"channel\":\"A0\"},{\"dataType\":\"realTime\",\"title\":\"湿度\",\"address\":\"00:12:4B:00:02:CB:A8:52\",\"command\":{},\"tid\":\"fs_cup_620452\",\"channel\":\"A1\"},{\"dataType\":\"realTime\",\"title\":\"灯光\",\"address\":\"00:12:4B:00:03:A7:E1:17\",\"command\":{\"open\":{OD1=1,D1=?},\"close\":{CD1=1,D1=?}},\"tid\":\"ctr_switch_497389\",\"channel\":\"D1.1\"}]}";
		System.out.println(JsonFormatterTool.formatJson(jsonStr));
	}
}
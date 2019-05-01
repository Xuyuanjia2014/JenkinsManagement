import freemarker.core.ParseException;
import freemarker.template.*;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

public class FreemarkerUtil {
    public Template getTemplate(String name) {
        try {
            // 通过Freemaker的Configuration读取相应的ftl
            Configuration cfg = new Configuration();
            // 设定去哪里读取相应的ftl模板文件
            cfg.setDirectoryForTemplateLoading(new File( JenkinsHelper.getPath() ));
            // 在模板文件目录中找到名称为name的文件
            Template temp = cfg.getTemplate(name);
            return temp;
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Map<String, Object> getDefaultMap(){
        Map<String, Object> resMap= new HashMap<String, Object>();
        resMap.put("gitURL","https://github.com/Xuyuanjia2014/otcplatform.git");
        resMap.put("BUILD_NUMBER","${BUILD_NUMBER}");
        return resMap;
    }

    public String print(String name, Map<String, Object> root) {
        try {
            // 通过Template可以将模板文件输出到相应的流
            Template temp = this.getTemplate(name);
            Writer out = new StringWriter(2048);
            temp.process(root, out);
            return out.toString();
        } catch (TemplateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "";
    }

    public static void main(String[] args) {
        FreemarkerUtil fu = new FreemarkerUtil();
        String jobXml = fu.print("default.ftl",fu.getDefaultMap());
        System.out.println(jobXml);
        JenkinsHelper jP = new JenkinsHelper("http://127.0.0.1:8080/jenkins","admin","admin");
        jP.createJob("test",jobXml);
    }
}

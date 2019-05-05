import com.offbytwo.jenkins.JenkinsServer;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.io.SAXReader;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

public class JenkinsHelper {
    private JenkinsServer js;

    public JenkinsHelper(String url,String userName,String passwd){
        try {
            this.js = new JenkinsServer(new URI(url),userName,passwd);
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
    }

    public void getDefaultXML(String name){
        try {
            System.out.println(js.getJobXml(name));
            //System.out.println(js.getJob(name).);
            System.out.println(js.getJob(name).getFileFromWorkspace("target/otcplatform.war"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String readXML(String path){
        try {
            File f = new File(path);
            SAXReader reader = new SAXReader();
            Document doc = reader.read(f);
            return doc.asXML();
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        return "";
    }

    public static String getPath(){
        return System.getProperty("user.dir")+"\\target\\classes\\";
    }

    public void createJob(String name,String contents){
        try {
            //js.deleteJob(name);
            js.createJob(name,contents);
            //System.out.println(js.getJob(name).build().getQueueItemUrlPart());
            //js.updateJob("jobName",newJobXml);
            // 构建对应的job
            js.getJob(name).build();
            // 获取html格式日志
            js.getJob(name).getLastBuild().details().getConsoleOutputHtml();
            // 获取text格式日志
            js.getJob(name).getLastBuild().details().getConsoleOutputText();
            // 获取执行结果（是否成功）
            js.getJob(name).getLastBuild().details().getResult();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        JenkinsHelper jP = new JenkinsHelper("http://39.96.15.135:8080/jenkins","admin","admin");
        //jP.getDefaultXML("onceas-ali01-default-pipeline02-20190315103425");

        //System.out.println(jP.readXML(jP.getPath()+"default.ftl"));
        //jP.createJob("test",jP.readXML(jP.getPath()+ "default.ftl"));
        jP.getDefaultXML("test");
    }
}

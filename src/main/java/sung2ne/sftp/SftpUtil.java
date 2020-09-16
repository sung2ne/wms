package sung2ne.sftp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Vector;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

// SFTP 파일 업로드/다운로드
public class SftpUtil {

	private static final Logger logger = LoggerFactory.getLogger(SftpUtil.class);

	private Session session = null;
	private Channel channel = null;
	private ChannelSftp channelSftp = null;

	// 연결
	public void connect(String host, String userName, String password, int port) throws Exception {
		JSch jsch = new JSch();

		session = jsch.getSession(userName, host, port);
		session.setPassword(password);

		java.util.Properties config = new java.util.Properties();
		config.put("StrictHostKeyChecking", "no");
		session.setConfig(config);
		session.connect();

		channel = session.openChannel("sftp");
		channel.connect();

		channelSftp = (ChannelSftp) channel;
		logger.info("SFTP 연결 시작");
	}

	// 연결 종료
	public void disconnect() {
		if (session.isConnected()) {
			logger.info("SFTP 연결 종료");
			channelSftp.disconnect();
			channel.disconnect();
			session.disconnect();
		}
	}

	/*
	 * 파일 업로드
	 * @param dir	: 업로드 위치
	 * @param file	: 업로드 파일
	 */
	public void upload(String dir, File file) throws Exception {
		FileInputStream in = null;
		in = new FileInputStream(file);
		channelSftp.cd(dir);
		channelSftp.put(in, file.getName());

		if (in != null) {
			in.close();
		}

		logger.info("파일 업로드 완료");
	}

	// 다운로드
	/*
	 * 파일 다운로드
	 * @param dir	: 다운로드 위치(서버)
	 * @param file	: 다운로드 파일
	 * @param path	: 다운로드 위치(로컬)
	 */
	 public void download(String serverPath, String fileName, String clientPath) throws Exception {
        InputStream in = null;
        FileOutputStream out = null;

        channelSftp.cd(serverPath);
        in = channelSftp.get(fileName);

        out = new FileOutputStream(new File(clientPath));
        int i;

        while ((i = in.read()) != -1) {
        	out.write(i);
        }

        out.close();
        in.close();
        logger.info("파일 다운로드 완료: " + fileName);
	 }

	 /*
     * 경로의 파일 리스트
     * @param path
     * @return
     */
    public Vector<ChannelSftp.LsEntry> getFileList(String path) {

    	Vector<ChannelSftp.LsEntry> list = null;
    	try {
    		channelSftp.cd(path);
    		//System.out.println(" pwd : " + channelSftp.pwd());
    		list = channelSftp.ls(".");
		} catch (SftpException e) {
			e.printStackTrace();
			return null;
		}

    	return list;
    }
}

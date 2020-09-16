package sung2ne.etc;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.nio.charset.Charset;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

public class TLSClient
{
    public static byte[] bytRecvData;

    protected static void MemClear(byte[] paramArrayOfByte)
    {
        int i = 0;
        for (i = 0; i < paramArrayOfByte.length; i++) paramArrayOfByte[i] = 0;
        for (i = 0; i < paramArrayOfByte.length; i++) paramArrayOfByte[i] = -1;
        for (i = 0; i < paramArrayOfByte.length; i++) paramArrayOfByte[i] = 0;
    }

    public static Map<String, Object> Approval(String paramString1, int paramInt, String paramString2)  throws Exception
    {
        int i = 999;

        Map<String, Object> response = TCPClient(paramString1, paramInt, paramString2);

        //return i;
        return response;
    }

    @SuppressWarnings("resource")
	public static Map<String, Object> TCPClient(String paramString1, int paramInt, String paramString2) throws Exception {
    	Map<String, Object> response = new HashMap<String, Object>();

        int i = 0;
        int j = 3000;
        int k = 20000;
        try
        {
            SSLContext localSSLContext = null;

            localSSLContext = SSLContext.getInstance("TLSv1.2");
            localSSLContext.init(null, new TrustManager[] { new X509TrustManager() {
                @Override
                public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
                }

                @Override
                public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
                }

                @Override
                public X509Certificate[] getAcceptedIssuers() {
                    return new X509Certificate[0];
                }
            }}, new SecureRandom());

            SSLSocketFactory localSSLSocketFactory = localSSLContext.getSocketFactory();

            Socket localSocket = null;
            localSocket = new Socket();
            InetSocketAddress localInetSocketAddress = new InetSocketAddress(paramString1, paramInt);
            try
            {
                localSocket.setSoTimeout(k);
                localSocket.connect(localInetSocketAddress, j);
            } catch (Exception localException2) {
                bytRecvData = "".getBytes();
                //return -23;
                response.put("resultCode", "-23");
                response.put("resultMsg", "");
                return response;
            }

            SSLSocket localSSLSocket = (SSLSocket)localSSLSocketFactory.createSocket(localSocket, paramString1, paramInt, true);

            String[] arrayOfString = { "TLSv1.2" };
            localSSLSocket.setEnabledProtocols(arrayOfString);

            localSSLSocket.startHandshake();

            BufferedOutputStream localBufferedOutputStream1 = null;
            localBufferedOutputStream1 = new BufferedOutputStream(localSSLSocket.getOutputStream());
            BufferedOutputStream localBufferedOutputStream2 = null;
            localBufferedOutputStream2 = new BufferedOutputStream(localSocket.getOutputStream());

            BufferedReader localBufferedReader = new BufferedReader(new InputStreamReader(localSSLSocket.getInputStream(), Charset.forName("EUC-KR")));
            byte[] arrayOfByte = new byte[paramString2.getBytes().length];

            arrayOfByte = paramString2.getBytes();

            for (int m = 0; m < paramString2.getBytes().length; m++) {
                localBufferedOutputStream1.write(arrayOfByte[m]);
            }

            localBufferedOutputStream1.flush();
            localBufferedOutputStream2.flush();

            MemClear(arrayOfByte);

            String str = localBufferedReader.readLine();

            if ((str == null) || (str.length() == 0))
            {
                i = -1;
                bytRecvData = "".getBytes();

                response.put("resultCode", i);
                response.put("resultMsg", "");
            }
            else
            {
                bytRecvData = str.getBytes("EUC-KR");

                response.put("resultCode", i);
                response.put("resultMsg", str);
            }

            localSSLSocket.close();
            localSocket.close();
            localBufferedOutputStream1.close();
            localBufferedOutputStream2.close();
        }
        catch (Exception localException1)
        {
            localException1.printStackTrace();
            i = -1;

            response.put("resultCode", i);
            response.put("resultMsg", "");
        }

        //return i;
        return response;
    }
}

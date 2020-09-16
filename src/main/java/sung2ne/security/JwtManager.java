package sung2ne.security;

import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import wms.domain.UserVo;
import io.jsonwebtoken.ClaimJwtException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JwtManager {

    //private static final Key secret = MacProvider.generateKey(SignatureAlgorithm.HS256);
    //private static final byte[] secretBytes = secret.getEncoded();
    //private static final String base64SecretBytes = Base64.getEncoder().encodeToString(secretBytes);

    public static String generateToken(UserVo userVo) {
        String id = UUID.randomUUID().toString().replace("-", "");
        Date now = new Date();
        Date exp = new Date(System.currentTimeMillis() + (1000 * 60 * 60 * 24 * 21));	// 21일
        //Date exp = new Date(System.currentTimeMillis() + (1000 * 60 * 60 * 24));

        String tokenStr = Jwts.builder()
        				.setHeaderParam("typ", "JWT")
                        .setIssuer("JNPSOLUTION").setId(id)
                        .setIssuedAt(now)
                        .setNotBefore(now)
                        .setExpiration(exp)
                        .claim("userId", userVo.getUserId())
                        .claim("userName", userVo.getUserName())
                        //.signWith(SignatureAlgorithm.HS256,base64SecretBytes.getBytes()) //실운영시에는 주석풀것
                        .signWith(SignatureAlgorithm.HS256, "65c82833-11b7-4005-8b3a-6f341b92e39e".getBytes()) // 개발시에만사용할것
                        .compact();
        return tokenStr;
    }

    public static HashMap<String, Object> verifyToken(String token) throws Exception {
    	HashMap<String, Object> tokenMap = new HashMap<String, Object>();
        String tokenCode = "1";

    	if ( token.equals(null) || token.equals("") ) {
    		tokenCode = "3";
    	} else {
            try {
                Claims claims = Jwts.parser()
                			//.setSigningKey(base64SecretBytes.getBytes()) //실운영시에는 주석풀것
                            .setSigningKey("65c82833-11b7-4005-8b3a-6f341b92e39e".getBytes()) // 개발시에만 사용할것
                            .parseClaimsJws(token).getBody();
                tokenMap.put("idx", claims.get("idx").toString());
                tokenMap.put("userId", claims.get("userId").toString());
                tokenMap.put("name", claims.get("name").toString());
            } catch (ExpiredJwtException e) {
                tokenCode = "2"; //유효기간 만료

            } catch (ClaimJwtException e) {
                tokenCode = "3"; //잘못된 토큰
            }

            /*
             * ClaimJwtException: JWT 권한claim 검사가 실패했을 때
             * ExpiredJwtException: 유효 기간이 지난 JWT를 수신한 경우
             * MalformedJwtException: 구조적인 문제가 있는 JWT인 경우
             * PrematureJwtException: 접근이 허용되기 전인 JWT가 수신된 경우
             * SignatureException: 시그너처 연산이 실패하였거나, JWT의 시그너처 검증이 실패한 경우
             * UnsupportedJwtException: 수신한 JWT의 형식이 애플리케이션에서 원하는 형식과 맞지 않는 경우. 예를 들어, 암호화된 JWT를 사용하는 애프리케이션에 암호화되지 않은 JWT가 전달되는 경우에 이 예외가 발생합니다.
             */
    	}

        tokenMap.put("tokenCode", tokenCode);
        return tokenMap; //토큰 인증됨
    }
}

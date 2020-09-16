## mysql timezone

### mysql timezone 확인

```
mysql> select @@global.time_zone, @@session.time_zone;
```

### mysql timezone 변경

```
mysql> SET GLOBAL time_zone='Asia/Seoul';
mysql> SET time_zone='Asia/Seoul';
```

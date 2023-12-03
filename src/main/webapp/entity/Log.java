package entity;

import java.util.Date;

public class Log {
    private int id;
    private int level;
    private String ip;
    private int idAccount;
    private String src;
    private String content;
    private Date createAt;
    private int status;
    private String updateAt;

    public Log() {
    }

    public Log(int id, int level, String ip, int idAccount, String src, String content, Date createAt) {
        this.id = id;
        this.level = level;
        this.ip = ip;
        this.idAccount = idAccount;
        this.src = src;
        this.content = content;
        this.createAt = createAt;
    }

    public Log(int id, int level, String ip, int idAccount, String src, String content, Date createAt, int status, String updateAt) {
        this.id = id;
        this.level = level;
        this.ip = ip;
        this.idAccount = idAccount;
        this.src = src;
        this.content = content;
        this.createAt = createAt;
        this.status = status;
        this.updateAt = updateAt;
    }

    @Override
    public String toString() {
        return "Log{" +
                "id=" + id +
                ", level=" + level +
                ", ip='" + ip + '\'' +
                ", idAccount=" + idAccount +
                ", src='" + src + '\'' +
                ", content='" + content + '\'' +
                ", createAt=" + createAt +
                ", status=" + status +
                ", updateAt='" + updateAt + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public int getIdAccount() {
        return idAccount;
    }

    public void setIdAccount(int idAccount) {
        this.idAccount = idAccount;
    }

    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(String updateAt) {
        this.updateAt = updateAt;
    }
}

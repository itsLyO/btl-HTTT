package model;

import java.io.Serializable;
import java.util.Date;

public abstract class Member6 implements Serializable {
    private static final long serialVersionUID = 1L;

    protected int id;
    protected String username;
    protected String password;
    protected Date dob;
    protected String email;
    protected String tel;
    protected String role;
    protected String note;
    protected FullName6 fullName;
    protected Address6 address;

    public Member6() {
    }

    public Member6(int id, String username, String password, Date dob, String email, String tel, String role, String note) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.dob = dob;
        this.email = email;
        this.tel = tel;
        this.role = role;
        this.note = note;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public FullName6 getFullName() {
        return fullName;
    }

    public void setFullName(FullName6 fullName) {
        this.fullName = fullName;
    }

    public Address6 getAddress() {
        return address;
    }

    public void setAddress(Address6 address) {
        this.address = address;
    }

    public String getDisplayName() {
        if (fullName != null) {
            String fn = fullName.getFullName();
            if (!fn.isEmpty()) return fn;
        }
        return username != null ? username : "";
    }
}

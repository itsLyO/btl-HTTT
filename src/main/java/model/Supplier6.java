package model;

import java.io.Serializable;

public class Supplier6 implements Serializable {
    private static final long serialVersionUID = 1L;

    protected int id;
    protected String name;
    protected String taxCode;
    protected String email;
    protected String tel;
    protected String desc;
    protected Address6 address;

    public Supplier6() {
    }

    public Supplier6(int id, String name, String taxCode, String email, String tel, String desc) {
        this.id = id;
        this.name = name;
        this.taxCode = taxCode;
        this.email = email;
        this.tel = tel;
        this.desc = desc;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTaxCode() {
        return taxCode;
    }

    public void setTaxCode(String taxCode) {
        this.taxCode = taxCode;
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

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Address6 getAddress() {
        return address;
    }

    public void setAddress(Address6 address) {
        this.address = address;
    }
}

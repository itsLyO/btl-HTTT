package model;

import java.io.Serializable;

public class Service6 implements Serializable {
    private static final long serialVersionUID = 1L;

    protected int id;
    protected String name;
    protected float price;
    protected int estDuration;
    protected String desc;
    protected String warrantyNote;

    public Service6() {
    }

    public Service6(int id, String name, float price, int estDuration, String desc, String warrantyNote) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.estDuration = estDuration;
        this.desc = desc;
        this.warrantyNote = warrantyNote;
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

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getEstDuration() {
        return estDuration;
    }

    public void setEstDuration(int estDuration) {
        this.estDuration = estDuration;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getWarrantyNote() {
        return warrantyNote;
    }

    public void setWarrantyNote(String warrantyNote) {
        this.warrantyNote = warrantyNote;
    }

    public String getCode() {
        return String.format("DV%03d", id);
    }
}

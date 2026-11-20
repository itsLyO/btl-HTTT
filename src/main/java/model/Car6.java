package model;

import java.io.Serializable;

public class Car6 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String plateNumber;
    private String brand;
    private String model;
    private int year;
    private String color;
    private String frameNumber;
    private String engineNumber;
    private String desc;
    private Customer6 customer;

    public Car6() {
    }

    public Car6(int id, String plateNumber, String brand, String model, int year, String color, String frameNumber, String engineNumber, String desc) {
        this.id = id;
        this.plateNumber = plateNumber;
        this.brand = brand;
        this.model = model;
        this.year = year;
        this.color = color;
        this.frameNumber = frameNumber;
        this.engineNumber = engineNumber;
        this.desc = desc;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public void setPlateNumber(String plateNumber) {
        this.plateNumber = plateNumber;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getFrameNumber() {
        return frameNumber;
    }

    public void setFrameNumber(String frameNumber) {
        this.frameNumber = frameNumber;
    }

    public String getEngineNumber() {
        return engineNumber;
    }

    public void setEngineNumber(String engineNumber) {
        this.engineNumber = engineNumber;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Customer6 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer6 customer) {
        this.customer = customer;
    }

    public String getCarInfo() {
        return (brand != null ? brand + " " : "") + (model != null ? model : "") + " (" + (plateNumber != null ? plateNumber : "") + ")";
    }

    @Override
    public String toString() {
        return getCarInfo();
    }
}

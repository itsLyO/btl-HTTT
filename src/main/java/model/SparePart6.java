package model;

import java.io.Serializable;

public class SparePart6 implements Serializable {
    private static final long serialVersionUID = 1L;

    protected int id;
    protected String name;
    protected String manufacturer;
    protected String unit;
    protected float unitPrice;
    protected float importPriceRef;
    protected int stockQuantity;
    protected String desc;

    public SparePart6() {
    }

    public SparePart6(int id, String name, String manufacturer, String unit, float unitPrice, float importPriceRef, int stockQuantity, String desc) {
        this.id = id;
        this.name = name;
        this.manufacturer = manufacturer;
        this.unit = unit;
        this.unitPrice = unitPrice;
        this.importPriceRef = importPriceRef;
        this.stockQuantity = stockQuantity;
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

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public float getImportPriceRef() {
        return importPriceRef;
    }

    public void setImportPriceRef(float importPriceRef) {
        this.importPriceRef = importPriceRef;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getCode() {
        return String.format("PT%03d", id);
    }
}

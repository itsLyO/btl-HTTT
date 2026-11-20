package model;

import java.io.Serializable;

public class ImportDetail6 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int quantity;
    private float importPrice;
    private ImportBill6 importBill;
    private SparePart6 sparePart;

    public ImportDetail6() {
    }

    public ImportDetail6(int id, int quantity, float importPrice) {
        this.id = id;
        this.quantity = quantity;
        this.importPrice = importPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(float importPrice) {
        this.importPrice = importPrice;
    }

    public ImportBill6 getImportBill() {
        return importBill;
    }

    public void setImportBill(ImportBill6 importBill) {
        this.importBill = importBill;
    }

    public SparePart6 getSparePart() {
        return sparePart;
    }

    public void setSparePart(SparePart6 sparePart) {
        this.sparePart = sparePart;
    }

    public float getSubTotal() {
        return quantity * importPrice;
    }
}

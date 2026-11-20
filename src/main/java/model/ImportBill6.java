package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ImportBill6 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date importDate;
    private float totalAmount;
    private String note;
    private Supplier6 supplier;
    private InventoryStaff6 inventoryStaff;
    private List<ImportDetail6> importDetails = new ArrayList<>();

    public ImportBill6() {
    }

    public ImportBill6(int id, Date importDate, float totalAmount, String note) {
        this.id = id;
        this.importDate = importDate;
        this.totalAmount = totalAmount;
        this.note = note;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public float getTotalAmount() {
        if (totalAmount > 0) return totalAmount;
        float total = 0f;
        if (importDetails != null) {
            for (ImportDetail6 d : importDetails) {
                total += d.getQuantity() * d.getImportPrice();
            }
        }
        return total;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Supplier6 getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier6 supplier) {
        this.supplier = supplier;
    }

    public InventoryStaff6 getInventoryStaff() {
        return inventoryStaff;
    }

    public void setInventoryStaff(InventoryStaff6 inventoryStaff) {
        this.inventoryStaff = inventoryStaff;
    }

    public List<ImportDetail6> getImportDetails() {
        return importDetails;
    }

    public void setImportDetails(List<ImportDetail6> importDetails) {
        this.importDetails = importDetails;
    }

    public String getBillCode() {
        return String.format("DN%03d", id);
    }
}

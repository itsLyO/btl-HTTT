package model;

import java.io.Serializable;

public class UsedSparePart6 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int quantity;
    private float actualPrice;
    private ReceptionSlip6 receptionSlip;
    private SparePart6 sparePart;

    public UsedSparePart6() {
    }

    public UsedSparePart6(int id, int quantity, float actualPrice) {
        this.id = id;
        this.quantity = quantity;
        this.actualPrice = actualPrice;
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

    public float getActualPrice() {
        return actualPrice;
    }

    public void setActualPrice(float actualPrice) {
        this.actualPrice = actualPrice;
    }

    public ReceptionSlip6 getReceptionSlip() {
        return receptionSlip;
    }

    public void setReceptionSlip(ReceptionSlip6 receptionSlip) {
        this.receptionSlip = receptionSlip;
    }

    public SparePart6 getSparePart() {
        return sparePart;
    }

    public void setSparePart(SparePart6 sparePart) {
        this.sparePart = sparePart;
    }

    public float getSubTotal() {
        return quantity * actualPrice;
    }
}

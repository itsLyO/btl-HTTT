package model;

import java.io.Serializable;
import java.util.Date;

public class Invoice6 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date paymentDate;
    private float totalAmount;
    private String paymentMethod;
    private String note;
    private ReceptionSlip6 receptionSlip;
    private SalesStaff6 salesStaff;

    public Invoice6() {
    }

    public Invoice6(int id, Date paymentDate, float totalAmount, String paymentMethod, String note) {
        this.id = id;
        this.paymentDate = paymentDate;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.note = note;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public float getTotalAmount() {
        if (totalAmount > 0) return totalAmount;
        if (receptionSlip != null) {
            return receptionSlip.getTotalAmount();
        }
        return 0f;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public ReceptionSlip6 getReceptionSlip() {
        return receptionSlip;
    }

    public void setReceptionSlip(ReceptionSlip6 receptionSlip) {
        this.receptionSlip = receptionSlip;
    }

    public SalesStaff6 getSalesStaff() {
        return salesStaff;
    }

    public void setSalesStaff(SalesStaff6 salesStaff) {
        this.salesStaff = salesStaff;
    }

    public String getInvoiceCode() {
        return String.format("HD%03d", id);
    }
}

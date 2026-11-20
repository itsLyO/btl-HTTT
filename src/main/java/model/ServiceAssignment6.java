package model;

import java.io.Serializable;

public class ServiceAssignment6 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private float actualPrice;
    private String status;
    private String note;
    private ReceptionSlip6 receptionSlip;
    private Service6 service;
    private Technician6 technician;

    public ServiceAssignment6() {
    }

    public ServiceAssignment6(int id, float actualPrice, String status, String note) {
        this.id = id;
        this.actualPrice = actualPrice;
        this.status = status;
        this.note = note;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getActualPrice() {
        return actualPrice;
    }

    public void setActualPrice(float actualPrice) {
        this.actualPrice = actualPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public Service6 getService() {
        return service;
    }

    public void setService(Service6 service) {
        this.service = service;
    }

    public Technician6 getTechnician() {
        return technician;
    }

    public void setTechnician(Technician6 technician) {
        this.technician = technician;
    }
}

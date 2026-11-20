package model;

import java.io.Serializable;
import java.util.Date;

public class Appointment6 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date appointDate;
    private String note;
    private String status;
    private Customer6 customer;
    private Car6 car;
    private Service6 service;

    public Appointment6() {
    }

    public Appointment6(int id, Date appointDate, String note, String status) {
        this.id = id;
        this.appointDate = appointDate;
        this.note = note;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getAppointDate() {
        return appointDate;
    }

    public void setAppointDate(Date appointDate) {
        this.appointDate = appointDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Customer6 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer6 customer) {
        this.customer = customer;
    }

    public Car6 getCar() {
        return car;
    }

    public void setCar(Car6 car) {
        this.car = car;
    }

    public Service6 getService() {
        return service;
    }

    public void setService(Service6 service) {
        this.service = service;
    }
}

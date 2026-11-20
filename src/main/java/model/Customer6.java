package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Customer6 extends Member6 {
    private static final long serialVersionUID = 1L;

    protected String type;
    protected List<Car6> cars = new ArrayList<>();
    protected List<Appointment6> appointments = new ArrayList<>();

    public Customer6() {
        super();
        this.role = "Customer";
    }

    public Customer6(int id, String username, String password, Date dob, String email, String tel, String role, String note, String type) {
        super(id, username, password, dob, email, tel, role, note);
        this.type = type;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<Car6> getCars() {
        return cars;
    }

    public void setCars(List<Car6> cars) {
        this.cars = cars;
    }

    public List<Appointment6> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment6> appointments) {
        this.appointments = appointments;
    }

    public String getCustomerCode() {
        return String.format("KH%03d", id);
    }
}

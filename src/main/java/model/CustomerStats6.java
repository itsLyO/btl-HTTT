package model;

import java.util.Date;

public class CustomerStats6 extends Customer6 {
    private static final long serialVersionUID = 1L;

    private int totalVisits;
    private float totalRevenue;

    public CustomerStats6() {
        super();
    }

    public CustomerStats6(int id, String username, String password, Date dob, String email, String tel, String role, String note, String type, int totalVisits, float totalRevenue) {
        super(id, username, password, dob, email, tel, role, note, type);
        this.totalVisits = totalVisits;
        this.totalRevenue = totalRevenue;
    }

    public int getTotalVisits() {
        return totalVisits;
    }

    public void setTotalVisits(int totalVisits) {
        this.totalVisits = totalVisits;
    }

    public float getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(float totalRevenue) {
        this.totalRevenue = totalRevenue;
    }
}

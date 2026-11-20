package model;

import java.util.Date;

public abstract class Employee6 extends Member6 {
    private static final long serialVersionUID = 1L;

    protected String position;

    public Employee6() {
        super();
    }

    public Employee6(int id, String username, String password, Date dob, String email, String tel, String role, String note, String position) {
        super(id, username, password, dob, email, tel, role, note);
        this.position = position;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}

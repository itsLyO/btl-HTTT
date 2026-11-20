package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ReceptionSlip6 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date receiveDate;
    private int currentKm;
    private String carStatus;
    private String status;
    private Customer6 customer;
    private SalesStaff6 salesStaff;
    private Car6 car;
    private List<ServiceAssignment6> serviceAssignments = new ArrayList<>();
    private List<UsedSparePart6> usedSpareParts = new ArrayList<>();
    private Invoice6 invoice;
    private transient float calculatedTotal;

    public ReceptionSlip6() {
    }

    public ReceptionSlip6(int id, Date receiveDate, int currentKm, String carStatus, String status) {
        this.id = id;
        this.receiveDate = receiveDate;
        this.currentKm = currentKm;
        this.carStatus = carStatus;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getReceiveDate() {
        return receiveDate;
    }

    public void setReceiveDate(Date receiveDate) {
        this.receiveDate = receiveDate;
    }

    public int getCurrentKm() {
        return currentKm;
    }

    public void setCurrentKm(int currentKm) {
        this.currentKm = currentKm;
    }

    public String getCarStatus() {
        return carStatus;
    }

    public void setCarStatus(String carStatus) {
        this.carStatus = carStatus;
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

    public SalesStaff6 getSalesStaff() {
        return salesStaff;
    }

    public void setSalesStaff(SalesStaff6 salesStaff) {
        this.salesStaff = salesStaff;
    }

    public Car6 getCar() {
        return car;
    }

    public void setCar(Car6 car) {
        this.car = car;
    }

    public List<ServiceAssignment6> getServiceAssignments() {
        return serviceAssignments;
    }

    public void setServiceAssignments(List<ServiceAssignment6> serviceAssignments) {
        this.serviceAssignments = serviceAssignments;
    }

    public List<UsedSparePart6> getUsedSpareParts() {
        return usedSpareParts;
    }

    public void setUsedSpareParts(List<UsedSparePart6> usedSpareParts) {
        this.usedSpareParts = usedSpareParts;
    }

    public Invoice6 getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice6 invoice) {
        this.invoice = invoice;
    }

    public void setCalculatedTotal(float calculatedTotal) {
        this.calculatedTotal = calculatedTotal;
    }

    public String getSlipCode() {
        return String.format("PNX%03d", id);
    }

    public float getTotalAmount() {
        if (invoice != null && invoice.getTotalAmount() > 0) return invoice.getTotalAmount();
        float total = 0f;
        if (serviceAssignments != null) {
            for (ServiceAssignment6 sa : serviceAssignments) {
                total += sa.getActualPrice();
            }
        }
        if (usedSpareParts != null) {
            for (UsedSparePart6 usp : usedSpareParts) {
                total += usp.getQuantity() * usp.getActualPrice();
            }
        }
        if (total > 0f) return total;
        return calculatedTotal;
    }
}

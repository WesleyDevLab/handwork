/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rashjz.info.com.az.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 *
 * @author rasha_000
 */
@Entity
@Table(name = "product_view")
@NamedQueries({
    @NamedQuery(name = "ProductView.findAll", query = "SELECT p FROM ProductView p"),
    @NamedQuery(name = "ProductView.findByProductId", query = "SELECT p FROM ProductView p WHERE p.productId = :productId"),
    @NamedQuery(name = "ProductView.findByCount", query = "SELECT p FROM ProductView p WHERE p.count = :count")})
public class ProductView implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "product_id")
    private Integer productId;
    @Basic(optional = false)
    @NotNull
    @Column(name = "count")
    private int count;
    @JoinColumn(name = "product_id", referencedColumnName = "p_id", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private Products products;

    public ProductView() {
    }

    public ProductView(Integer productId) {
        this.productId = productId;
    }

    public ProductView(Integer productId, int count) {
        this.productId = productId;
        this.count = count;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public Products getProducts() {
        return products;
    }

    public void setProducts(Products products) {
        this.products = products;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productId != null ? productId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProductView)) {
            return false;
        }
        ProductView other = (ProductView) object;
        if ((this.productId == null && other.productId != null) || (this.productId != null && !this.productId.equals(other.productId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "rashjz.info.com.az.entity.ProductView[ productId=" + productId + " ]";
    }
    
}

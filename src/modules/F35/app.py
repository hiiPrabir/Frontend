import streamlit as st
import pandas as pd

# 1. Page Configuration
st.set_page_config(page_title="Module F35: Therapy Evaluation", layout="wide")
st.title("⚕️ Therapy Effectiveness Evaluation System")
st.markdown("**Module F35** | Clinical Decision Support Dashboard")

# 2. Sidebar Navigation
st.sidebar.header("Navigation")
menu = st.sidebar.radio("Go to:", ["📝 Enter Therapy Data", "📊 Effectiveness Report"])

# 3. PAGE 1: Data Entry Form (Matches your API Input Flow)
if menu == "📝 Enter Therapy Data":
    st.subheader("Record New Therapy & Response")
    
    with st.form("therapy_form"):
        col1, col2 = st.columns(2)
        
        with col1:
            patient_id = st.text_input("Patient ID (e.g., P-1001)")
            therapy_name = st.text_input("Therapy/Drug Name")
            dosage = st.text_input("Dosage")
            
        with col2:
            treatment_cost = st.number_input("Treatment Cost (₹)", min_value=0)
            improvement_score = st.slider("Improvement Score (0-100%)", 0, 100, 50)
            toxicity_grade = st.selectbox("Side Effect Toxicity Grade", [0, 1, 2, 3, 4])
            
        submit_button = st.form_submit_button(label="Submit to Database")
        
        if submit_button:
            # This is where your Python API would execute the SQL INSERT commands
            if toxicity_grade >= 3:
                st.error("🚨 CLINICAL ALERT: High toxicity detected. Database Trigger activated!")
            else:
                st.success(f"Therapy recorded! QALY Score will be calculated for Patient {patient_id}.")

# 4. PAGE 2: The SQL View Dashboard
elif menu == "📊 Effectiveness Report":
    st.subheader("Global Therapy Effectiveness (QALY Analysis)")
    st.info("This table pulls data directly from the Cost_Analysis and Response SQL Views.")
    
    # Mock data to simulate what your SQL Stored Procedure outputs
    mock_data = {
        "Therapy ID": ["T-001", "T-002", "T-003"],
        "Drug Name": ["Immunotherapy A", "Chemo Protocol B", "Targeted Therapy C"],
        "Treatment Cost": ["₹ 1,50,000", "₹ 85,000", "₹ 2,10,000"],
        "Improvement Score": ["85%", "60%", "92%"],
        "Calculated QALY": [0.85, 0.60, 0.92]
    }
    
    df = pd.DataFrame(mock_data)
    st.table(df)

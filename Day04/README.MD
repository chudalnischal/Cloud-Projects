# Python System Monitoring & Weather API - Day 4

Three Python applications demonstrating system monitoring and API integration.

## 📂 Project Files

### 1. `usages.py` - System Resource Monitor
**Key Learnings:**
- Real-time CPU/memory monitoring using `psutil`
- Continuous system polling with interval control
- Keyboard interrupt handling for clean exits
- Practical system diagnostics implementation

### 2. `flask-system.py` - System Health API
**Key Learnings:**
- Building RESTful endpoints with Flask
- Structured JSON response formatting
- Comprehensive disk usage metrics
- Web service deployment (0.0.0.0 binding)
- Production-ready system monitoring API

### 3. `flask-weather.py` - Weather Service
**Key Learnings:**
- Third-party API integration (OpenWeatherMap)
- Query parameter handling in Flask
- Response data transformation
- Comprehensive error handling
- Metric/Imperial unit conversion

## 🚀 How to Use

Install the required dependencies:
```bash
pip install psutil flask requests
```
Run each file separately to see its functionality:
```bash
python usages.py for system monitoring
python flask_system_usages.py for the system health API
python flask_weather_api.py for the weather API (requires OpenWeatherMap API key)
```

Each file demonstrates different but complementary aspects of Python programming, from system-level operations to web services and API integrations.
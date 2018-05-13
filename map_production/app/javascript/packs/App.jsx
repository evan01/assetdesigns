import React from "react";
import ReactDOM from "react-dom";
import PropTypes from "prop-types";
import { Page, Card, Button, Tabs, AppProvider } from "@shopify/polaris";
import Suppliers from "./Suppliers";
import SupplyChains from "./SupplyChains";

class App extends React.Component {
    state = {
        selected: 0,
        tabs: [
            {
                id: "Suppliers",
                content: "Suppliers",
                panelID: "Suppliers-content"
            },
            {
                id: "Supply Chains",
                content: "Supply Chains",
                panelID: "supply-chains-content"
            }
        ]
    };

    handleTabChange = tabIndex => {
        //First set the tab state to be selected
        this.setState({ selected: tabIndex });
    };

    renderSuppliers = () => {
        //First get the suppliers from API
        const suppliers = this.props.suppliers;
        return (<Suppliers suppliersList={suppliers} />);
        //Then render a suppliers view with the data
    };

    renderSupplyChains = () => {
        //First get the supply chains from the API
        const supplyChains = this.props.supplyChains;
        //Then render a supply chains view with the data
    return (<SupplyChains />);
    };

    render() {
        const apiKey = this.props.shop_session.token;
        const origin = "https://" + this.props.shop_session.url;
        return (
            <AppProvider shopOrigin={origin} apiKey={apiKey}>
                <Page title="Home" separator>
                    <Card>
                        <Tabs
                            tabs={this.state.tabs}
                            selected={this.state.selected}
                            onSelect={this.handleTabChange}
                        />
                        <Card.Section>
                            {(this.state.selected === 0)
                                ? this.renderSuppliers()
                                : this.renderSupplyChains()}
                            <p>Tab {this.state.selected} selected</p>
                        </Card.Section>
                    </Card>
                </Page>
            </AppProvider>
        );
    }
}

// Render component with data
document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("App_Container");
    const data = JSON.parse(node.getAttribute("data"));
    ReactDOM.render(<App {...data} />, node);
});

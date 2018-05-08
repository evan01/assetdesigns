import React from "react";
import ReactDOM from "react-dom";
import PropTypes from "prop-types";
import {
    Page,
    Card,
    Button,
    Thumbnail,
    AppProvider,
    Tabs
} from "@shopify/polaris";

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
      this.setState({selected: tabIndex})
    };

    render() {
        // const shopOrigin = document.querySelector("#ShopOrigin").textContent;
        // const apiKey = document.querySelector("#APIKey").textContent;
        const apiKey = this.props.shop_session.token
        const origin = "https://" + this.props.shop_session.url
        return (
          <AppProvider shopOrigin={origin} apiKey={apiKey}>
                <Page title="Home" separator>
                    <Card>
                        <Tabs
                            tabs={this.state.tabs}
                            selected={this.state.selected}
                            onSelect={this.handleTabChange}
                        />
                        <Card.Section title={this.state.currentTab}>
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

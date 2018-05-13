import React from "react";
import _ from 'lodash';
import { Page, Card, Button, Tabs, ResourceList, Avatar, TextStyle } from "@shopify/polaris";

// This component needs to be able to do all CRUD actions for Suppliers
class Suppliers extends React.Component {
    state = {};

    renderSupplierListItem = item => {
        const { id, url, name, location, latestOrderUrl } = item;
        const media = <Avatar customer size="medium" name={name} />;
        const shortcutActions = latestOrderUrl
            ? [{ content: 'View latest order', url: latestOrderUrl }]
            : null;

        return (
            <ResourceList.Item
                id={id}
                url={url}
                media={media}
                accessibilityLabel={`View details for ${name}`}
                shortcutActions={shortcutActions}
            >
                <h3>
                    <TextStyle variation="strong">{name}</TextStyle>
                </h3>
                <div>{location}</div>
            </ResourceList.Item>
        );
    }

    renderSuppliersList = () => {
        console.log(this.props.suppliersList);
        let resourceName = { singular: 'supplier', plural: 'suppliers' };
        let suppliers = [
            {
                id: 341,
                url: 'customers/341',
                name: 'Mae Jemison',
                location: 'Decatur, USA',
                latestOrderUrl: 'orders/1456',
            },
            {
                id: 256,
                url: 'customers/256',
                name: 'Ellen Ochoa',
                location: 'Los Angeles, USA',
                latestOrderUrl: 'orders/1457',
            },
        ];

        return (
            <Card>
                <ResourceList
                    resourceName={ resourceName }
                    items= { suppliers }
                    renderItem={this.renderSupplierListItem}
                />
            </Card>
        );
    };

    render = () => {
        return (
            <div>
                {this.renderSuppliersList()}
            </div>
        );
    }
}

export default Suppliers;
